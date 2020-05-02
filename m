Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04FCC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F15221582
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588381460;
	bh=JtIPM1h34I4AhmZ1VVbUEA6GoUJy4wuPXZ6Ni6fsTS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=a9X8PwQTXst2GVMvIpji9HaeMvO4mtZi0JLt2Hso/fmGv/S7JE25bZS1u1ZFaoFsX
	 cNLo39RfO6z55gam1aAOXUPKtDUFkFZzZm4Y6VftiiJX+17M7sDYc2BCzAASScqHDg
	 adjvr23OQthBzhOh3sIOuzfRBahep7ILNDiGE6Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEBBET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 21:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgEBBET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 21:04:19 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D729E208DB;
        Sat,  2 May 2020 01:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588381459;
        bh=JtIPM1h34I4AhmZ1VVbUEA6GoUJy4wuPXZ6Ni6fsTS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=na7y+JOF/7mHBXhRkg3mZeQxqmgkuLLA8fV4INfgkAKnkv2x6aBL3AYPOMl3fSUTP
         Yq0vNcO0aeYpGY3zI/ukT9UyIkfRTpdvGEdgACzUlnbbnxNZTlYM2YrX/IhQ9NlHAb
         Rlnm3czP5M+QJbsKw59nTduXRsj4198dwrwVg/g0=
Date:   Fri, 1 May 2020 18:04:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH] checkpatch: add NL_SET_ERR_MSG to 80 column exceptions
Message-ID: <20200501180417.09bcb6e8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <02874ECE860811409154E81DA85FBB58C0774F94@ORSMSX151.amr.corp.intel.com>
References: <20200501231131.2389319-1-jacob.e.keller@intel.com>
        <e1e12e3f6992c00c005ba2b3bcf671c033a1dccc.camel@perches.com>
        <5a1da586-0cc0-1900-477f-6fef61af7f95@intel.com>
        <1c86e75bb56693bc2343d30e5baba09c783b02a2.camel@perches.com>
        <02874ECE860811409154E81DA85FBB58C0774F94@ORSMSX151.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 May 2020 00:36:48 +0000 Keller, Jacob E wrote:
> > The ones I specified previously use:
> > 
> > 	NL_SET_ERR_MSG_MOD(extack, "message\n");
> > 
> > where all the others uses are:
> > 
> > 	NL_SET_ERR_MSG_MOD(extack, "message");
> > 
> > without the \n termination of the message.
> >   
> 
> I see. Yea, I think the trailing newline isn't needed, but I'm not sure.

Yup, there should be no new line at the end of an extack message.
