Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA68C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9D520672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594335075;
	bh=roZLSbx21j3G3eSkCI1wgvCoE595TsZU94qEPul4Oc0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=kJKg8/0iyX7WDW+A9fyj5k8Y/XGB8AdoJFFGcPoHGLixLLJVZoQ2Nye4aPVkZCfDz
	 4oi21VMlYcX/DuEhyxLNrmSnMbnKXj7jabmSyp6vxjU3E7PO53HJpoQRvlq2LmHLC2
	 ff0oTKsrH6lrEqyG8wH/7W13+dP5TkeDJ02Wc100=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGIWvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgGIWvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:51:14 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D17020672;
        Thu,  9 Jul 2020 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594335073;
        bh=roZLSbx21j3G3eSkCI1wgvCoE595TsZU94qEPul4Oc0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Dw0W7B4+6L/Ua29pgOi44mw8wP5+4d+tiaMlTazDDnXnUtI98AezyrUgGbUb+QVAK
         rW5RsCThCftZOLKcIZLhwFOrWRR3+bv8CuvStKsMbql+P6bqppsvQo0SofyrAApMF4
         ZOYbB9Vj169bs9lflL66nxUZeUrGZSqifcUJhgdM=
Date:   Fri, 10 Jul 2020 00:50:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: Explain why plain text is
 preferred
In-Reply-To: <202007091110.205DC6A9@keescook>
Message-ID: <nycvar.YFH.7.76.2007100050360.23768@cbobk.fhfr.pm>
References: <202007091110.205DC6A9@keescook>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020, Kees Cook wrote:

> The security contact list gets regular reports contained in archive
> attachments. This tends to add some back-and-forth delay in dealing with
> security reports since we have to ask for plain text, etc.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

