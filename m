Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02222C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F3A206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="B1ylECLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENKqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:46:16 -0400
Received: from smtp2.axis.com ([195.60.68.18]:64723 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENKqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1223; q=dns/txt; s=axis-central1;
  t=1589453175; x=1620989175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/QiWqwCY0he86CmS8M6CKwlH1XkaAD8P1wAxOQ7yl8o=;
  b=B1ylECLI8/hWe4kwqfHPLy6Kgb9spiudr8ng/vxtIoz9LMMyfZKWUccx
   SG2F1pmEMUKWL7AhwgxghsO9QpOkfJkTIpWfD7gflrtHPK/ukebCAMhjZ
   j6ldM+Gddado5RwBcica+PW22Ty2VG2uZc271j8ovPGaFqyUAO0meMuv1
   qEzIhMCqBvWfoQR1gnqRXArZXJwOwrkDYFd/FHFHomsNpwt9vZKAd+u/s
   O7lEoZF0WRQ1xC/5oxiHb4v17cFlUR05H8/YlmWZyhnNsIL7Ry0Jh/pfe
   fgYwmZ7//R8wwPZM/htxfKfuAKLTGBGXbPmN80InMAUVSq4WgvtjZEMTn
   g==;
IronPort-SDR: UMWgmyq8sHVnEMDqeVGc2t7zv76i5GtdkN/IP/73570nJPpt2kmZ+BFcwYp9oN3g7OBVbm1l3v
 huRpu5fhUBp0Z4iYWpurCRZ98ucDhxRYqKh4ZwdVLAbYEHmXPdFjPMGf5VclcoYFal+dsZqfqQ
 Y0cnyF6tvBatWVX7DH7gCoKJvn86ehyVSQ0alfCM+2tmDc5lqdFSQxjk6pPPiqULeYGTKXC+dj
 cu9gKsF1u9qJ+BrLSGpQ5AUqmfzweTFYkurlIk/vrxXLzG7GmzsoXq7Rr9KQ9hetQyp98Kb9tV
 nu4=
X-IronPort-AV: E=Sophos;i="5.73,391,1583190000"; 
   d="scan'208";a="8479237"
Date:   Thu, 14 May 2020 12:46:13 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jessica Yu <jeyu@kernel.org>, <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH v2 1/2] module: allow arch overrides for .init section
 names
Message-ID: <20200514104613.ckwql7s4xbgqj7ss@axis.com>
References: <20200511114803.4475-1-vincent.whitchurch@axis.com>
 <20200511154459.GA26699@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200511154459.GA26699@linux-8ccs.fritz.box>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 05:45:00PM +0200, Jessica Yu wrote:
> +++ Vincent Whitchurch [11/05/20 13:48 +0200]:
> >ARM stores unwind information for .init.text in sections named
> >.ARM.extab.init.text and .ARM.exidx.init.text.  Since those aren't
> >currently recognized as init sections, they're allocated along with the
> >core section, and relocation fails if the core and the init section are
> >allocated from different regions and can't reach other.
> >
> >  final section addresses:
> >        ...
> >        0x7f800000 .init.text
> >        ..
> >        0xcbb54078 .ARM.exidx.init.text
> >        ..
> >
> > section 16 reloc 0 sym '': relocation 42 out of range (0xcbb54078 ->
> > 0x7f800000)
> >
> >Allow architectures to override the section name so that ARM can fix
> >this.
> >
> >Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> >---
> >v2: Add comment and move module_init_section() next to module_exit_section().
> 
> Thanks, this patch looks fine to me. You could add my:
> 
>    Acked-by: Jessica Yu <jeyu@kernel.org>
> 
> Alternatively, I can take this through modules-next if the second
> patch gets a review and ack from an ARM maintainer.

Thanks!  I've put the patches in Russell's patch system.
