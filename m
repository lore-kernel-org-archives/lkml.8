Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C42EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B8F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598368663;
	bh=3342eHQfGiqySCJ60Rokb2k+MC9TEiCx/jzHQWkDUHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Sdjizb1N/be4Jke0MwI9bQ4c9AXValEU3KeaNbVp5AyWrX2eiOn3G84cR+MpP0lO6
	 nBE+nSx0S1BcCzp1hpQGWuXuDUw+L/vWIPKE2H3CkzVgktENHxAluwWcquS4anwRpb
	 kzixtjP2yXGPO35FG24wmbKB7g7xl+oq01+39sOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgHYPRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgHYPQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:16:57 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B0720578;
        Tue, 25 Aug 2020 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598368617;
        bh=3342eHQfGiqySCJ60Rokb2k+MC9TEiCx/jzHQWkDUHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JMrka61eIH7XVw89wAecQ8ru9OT64OXexK91IvBcpq2DVeAmVBMHoYk5GxMeX4Ews
         n6xRqPYpkh9aLAucYd40fqQHSL44WIZ7XyZ0wbA6D/V1R7itkxp08qbJCrx5kdKmBl
         FGsC6FGD54nSxX2VYY4pFwZx/WV2PeTHGWyEKseM=
Date:   Tue, 25 Aug 2020 10:16:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
        Tomoya MORINAGA <tomoya.rohm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v2 2/2] i2c: eg20t: use generic power management
Message-ID: <20200825151655.GA1913382@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825115342.16ab9004@endymion>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:53:42AM +0200, Jean Delvare wrote:
> Hi Bjorn, Vaibhav,
> 
> On Fri, 07 Aug 2020 15:23:21 -0500, Bjorn Helgaas wrote:
> > Also, i801_suspend() looks suspicious because it writes SMBHSTCFG, but
> > I don't see anything corresponding in i801_resume().
> 
> You're right, it's buggy. Volker Rümelin's patch at:
> 
> https://patchwork.ozlabs.org/project/linux-i2c/patch/a2fc5a6d-a3bf-eaf0-bb75-1521be346333@googlemail.com/
> 
> should fix it. I was supposed to review it but did not, shame on me.
> I'll do it today.

Always nice when the fix is already there :)  Thanks for following up
on this!

Bjorn
