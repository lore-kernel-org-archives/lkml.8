Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812F4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 13:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568C220885
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596893272;
	bh=IKNDctw8eaqDUmhLYS20d90D4oduBKl5cJTRFCqj0Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PDtgFtNlIwTEEczt0LaEfTM8XbiW5ci3iTfR5m9b5rkzZlQ6kJADT8mJlKZJw1J+7
	 RCLJRzPFLwx6kiAkgc6Y8NTurXUMkuoD/kN+uCPSD/a8fVtyos2ZQpuyRiBB5jGefI
	 sxSBNG7GhauCLHTsd9zgVZx97PTRB9CzpjX89kko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHHN1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 09:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgHHN1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 09:27:50 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050382072D;
        Sat,  8 Aug 2020 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596893270;
        bh=IKNDctw8eaqDUmhLYS20d90D4oduBKl5cJTRFCqj0Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqNsO3UyVb3g8gWXLEvvIkNHLQ0pAjsqVwHYVD6761hq1w6VYDTGzsmcz5B25aRsZ
         oj4AhgRxiTRqWUcs0BM94uOdOiHeVEWFnCbxzbG4pSE/1pwVFAMvmfF7toYOfYdqZq
         FMg5m3Bv8Lj2JQABtsj+vI4gaRE1yhaCRcPsovyo=
Received: by pali.im (Postfix)
        id 1865B688; Sat,  8 Aug 2020 15:27:48 +0200 (CEST)
Date:   Sat, 8 Aug 2020 15:27:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Removal of HCI commands? (Was: Re: OCF_READ_LOCAL_CODECS is
 permitted only for root user)
Message-ID: <20200808132747.4byefjg5ysddgkel@pali>
References: <20191228171212.56anj4d4kvjeqhms@pali>
 <45BB2908-4E16-4C74-9DB4-8BAD93B42A21@holtmann.org>
 <20200104102436.bhqagqrfwupj6hkm@pali>
 <20200209132137.7pi4pgnassosh3ax@pali>
 <20200414225618.zgh5h4jexahfukdl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414225618.zgh5h4jexahfukdl@pali>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 April 2020 00:56:18 Pali Rohár wrote:
> On Sunday 09 February 2020 14:21:37 Pali Rohár wrote:
> > On Saturday 04 January 2020 11:24:36 Pali Rohár wrote:
> > > On Saturday 04 January 2020 10:44:52 Marcel Holtmann wrote:
> > > > Hi Pali,
> > > > 
> > > > > I wrote a simple script "sco_features.pl" which show all supported
> > > > > codecs by local HCI bluetooth adapter. Script is available at:
> > > > > 
> > > > > https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl
> > > > > 
> > > > > And I found out that OCF_READ_LOCAL_CODECS HCI command cannot be send by
> > > > > non-root user. Kernel returns "Operation not permitted" error.
> > > > > 
> > > > > What is reason that kernel blocks OCF_READ_LOCAL_CODECS command for
> > > > > non-root users? Without it (audio) application does not know which
> > > > > codecs local bluetooth adapter supports.
> > > > > 
> > > > > E.g. OCF_READ_LOCAL_EXT_FEATURES or OCF_READ_VOICE_SETTING commands can
> > > > > be send also by non-root user and kernel does not block them.
> > > > 
> > > > actually the direct access to HCI commands is being removed. So we have no plans to add new commands into the list since that it what the kernel is suppose to handle. If we wanted to expose this, then it has to be via mgmt.
> > > 
> > > Hi Marcel! Thank you for information. I have not know that this API is
> > > "deprecated" and is going to be removed. But userspace audio
> > > applications need to know what bluetooth adapter supports, so can you
> > > export result of these commands to userspace? My script linked above
> > > calls: OCF_READ_VOICE_SETTING, OCF_READ_LOCAL_COMMANDS,
> > > OCF_READ_LOCAL_EXT_FEATURES, OCF_READ_LOCAL_CODECS
> > 
> > Hello! Just a gently reminder for this question. How to retrieve
> > information about supported codecs from userspace by non-root user?
> > Because running all bluetooth audio applications by root is not really a
> > solution. Plus if above API for root user is going to be removed, what
> > is a replacement?
> 
> Hello!
> 
> I have not got any answer to my email from Marcel for months, so I'm
> adding other developers to loop. Could somebody tell me that is the
> replacement API if above one is going to be removed?
> 
> I was not able to find any documentation where could be described this
> API nor information about deprecation / removal.
> 
> And are you aware of the fact that removing of API could potentially
> break existing applications?
> 
> I really need to know which API should I use, because when I use API
> which is going to be removed, then my application stops working. And I
> really want to avoid it.
> 
> Also I have not got any response yet, how can I read list of supported
> codecs by bluetooth adapter by ordinary non-root user? Audio application
> needs to know list of supported codecs and it is really insane to run it
> as root.

Hello! This is just another reminder that I have not got any reply to
this email.

Does silence mean that audio applications are expected to work only
under root account and ordinary users are not able to use audio and list
supported codecs?
