Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729E0206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594104704;
	bh=gE9m6IM8qBh8PWfvrR+CeLupA3RereV+AmgFwG46lIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BS/Pj0HAMgnzdk/BIqXy6BaZ5XFILyEKGFo6tE/QBmi9tzE3956kOMj9/uoLrdgEC
	 VKpiTs3Dyljy/sYtRQIqfDRNxftVH1gaykrk+QHHkrVXgttdo0lE37QSy05Yp1KjqS
	 DStk0kAgsJ7w/UOz90V72yBSN8O3/FC5Y7SUAniE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGGGvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgGGGvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:51:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC78206F6;
        Tue,  7 Jul 2020 06:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594104702;
        bh=gE9m6IM8qBh8PWfvrR+CeLupA3RereV+AmgFwG46lIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPCYbO3B95dh7APnaAzWwVYxX65SkFvKxNHrM/HhbdhA+v2s7QmKQgD1cSowRMdl/
         ZxaxjrsWGMJDJj84qxzhb3QLaBGMrob9Ugo/19YfH4D2nahXscn8x4zUJRQFyq6xVq
         2+muqNyd1E+aKGU/LhTnReAtPh/Ju/MPFCUBmNQw=
Date:   Tue, 7 Jul 2020 08:51:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjNdIHVz?= =?utf-8?Q?b=3A?=
 gadget: function: fix missing spinlock in f_uac1_legacy
Message-ID: <20200707065139.GA5233@kroah.com>
References: <20200705124027.30011-1-qiang.zhang@windriver.com>
 <20200706195520.GA93712@kroah.com>
 <BYAPR11MB26323A0A7687EC2CE3C9E17FFF660@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB26323A0A7687EC2CE3C9E17FFF660@BYAPR11MB2632.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top


On Tue, Jul 07, 2020 at 02:28:36AM +0000, Zhang, Qiang wrote:
> Hi Greg KH
> In the early submission:
> "commit id c6994e6f067cf0fc4c6cca3d164018b1150916f8" which add USB Audio Gadget driver "   
> the "audio->play_queue" was protected from "audio->lock"
> spinlock in "playback_work" func, But in "f_audio_out_ep_complete" func 
> there is no protection for the operation of this "audio->play_queue". there
> are missing spinlock,  Fix tags should add up here commit？

I really do not understand what you are asking here, sorry.

greg k-h
