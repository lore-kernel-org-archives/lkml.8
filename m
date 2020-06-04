Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E690C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E69206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591305240;
	bh=2TgX524QxU5g09+EVKx4PYrPaxdDEGbnQte8wTn3A9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WHjU8iqrmGq1EVAVa1pbXDEZsjm7eom3TdFbUKFpadM2dsOZs+YT7OKpNuFRZCaPN
	 K3bjFLFtk+hGaDHMS73f4O7C5VuK/Jbo4iQzItbYrzrXm8giRkiOm2IWujrM5jKQzs
	 pXM4/2CqlOEa8Fzp8YgWlwJZEMREydcDr/H8ETEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgFDVN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgFDVN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:13:58 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B862067B;
        Thu,  4 Jun 2020 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591305238;
        bh=2TgX524QxU5g09+EVKx4PYrPaxdDEGbnQte8wTn3A9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0+MAxQDugaaDhNYggEouW+7JZaR1K/9qYg+H5ysAbLXSygx9WfUNMmDuZMy7whRf
         BNTFXnwKLHHmis/PZCa5lQE9+DHifYWmPjd7j+ji9JsqBbUNzzSWyrxlf0by09sIIV
         sZI0jHMx/cz2J2Kv1fiosjazgSo71R3qAQo18pl8=
Date:   Thu, 4 Jun 2020 16:19:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] docs: deprecated.rst: Add note to the use of
 struct_size() helper
Message-ID: <20200604211903.GF10051@embeddedor>
References: <20200604172138.GA21820@embeddedor>
 <202006041047.9B3E8FB951@keescook>
 <20200604182123.GD10051@embeddedor>
 <202006041322.35912ABB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006041322.35912ABB@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:25:26PM -0700, Kees Cook wrote:
> On Thu, Jun 04, 2020 at 01:21:23PM -0500, Gustavo A. R. Silva wrote:
> > Yeah. My reasoning for is that it will take a while --at least one 
> > development cycle more-- to completely get rid of all the 0/1-arrays.
> 
> Right -- but we need a place to point people when we tell them "please
> don't use 0-byte and 1-byte arrays", and the deprecated.rst is the place
> for that.
> 
> Having it in deprecated.rst once they're all gone only serves to explain
> why various compiler flags are enabled, etc. But while they're being
> removed, it serves as a single place to document the issue (as in, much
> of the flex-array patch commit log "boilerplate" can actually be
> repeated in deprecated.rst.
> 
> > But I think we can add this note while I continue working on the flexible-array
> > conversions. Once that work is complete, I can go back and update the
> > documentation. :)
> > 
> > What do you think?
> 
> I think we need to document it at the beginning of the work (and I
> should have asked for this earlier). So let's just add a new section on
> dynamic array usage, etc. It can include a note about struct_size() as
> an example for why 1-byte arrays are so weird. :)
> 

Got ya. :)

One last thing... I was thinking on adding such section (dynamic array
usage) to coding-style.rst, explaining how to use struct_size() and
transform the different open-coded versions we currently have in the
kernel, e.g. I have seen people use offsetof() --and sometimes open-coded
versions of sizeof_field()-- and its open-coded version to do arithmetic
in allocator arguments.

Thanks
--
Gustavo

