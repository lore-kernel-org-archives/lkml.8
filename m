Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E8DC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B749C206EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIBBpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:45:54 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47927 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726131AbgIBBow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:44:52 -0400
Received: (qmail 608512 invoked by uid 1000); 1 Sep 2020 21:44:51 -0400
Date:   Tue, 1 Sep 2020 21:44:51 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     gregkh@linuxfoundation.org, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 0/1] USB EHCI: repeated resets on full and low
 speed devices
Message-ID: <20200902014451.GA608383@rowland.harvard.edu>
References: <cover.1598887346.git.khalid@gonehiking.org>
 <20200901023117.GD571008@rowland.harvard.edu>
 <608418fa-b0ce-c2a4-ad79-fe505c842587@oracle.com>
 <20200901163602.GG587030@rowland.harvard.edu>
 <4d1ab90a-ec55-85e8-d646-cfa58f08d449@oracle.com>
 <20200901195159.GA599114@rowland.harvard.edu>
 <68228cc9-5d1a-6872-0956-a7006fe3b943@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68228cc9-5d1a-6872-0956-a7006fe3b943@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 04:54:48PM -0600, Khalid Aziz wrote:
> I have managed to find a hardware combination that seems to work, so for
> now at least my machine is usable. I will figure out how to interpret
> usbmon output and run more experiments. There seems to be a real problem
> in the driver somewhere and should be solved.

Correction: You're using two different drivers.  Although it's not 
impossible, it seems very unlikely that they both contain the same bug.

Alan Stern
