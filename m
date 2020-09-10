Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9420EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B773208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599769061;
	bh=+Uwc5UahmuCFhZYlV/hX/DJpXr+j00ks6tpmwU4b/+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PiDgXa9RP11YQoPw5gp4FAvSZHqsugwY9NfdinXpR0q6xFGReiCJPaMoAl683OjHS
	 h0KWWMEWKC0N3BMUnNFTIPA9k5sDF88AteQd74Mn3MKEm2Bw/VoQdeaT4B96m7WBxg
	 bG7GLZvc6yWQ3RDLbY4t/FFPyQ+UsvXieqx948v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIJUR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgIJUQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:16:32 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F4020829;
        Thu, 10 Sep 2020 20:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599768991;
        bh=+Uwc5UahmuCFhZYlV/hX/DJpXr+j00ks6tpmwU4b/+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R0ywRp5PhyRlRa7RSxir2ngnqYoi6YEyGdS+oOk3SGir2W3zS9WIHBLY0a2fwhCkW
         3SWTwsJGJBn431DFEutEp0ZnIYqfGVjjLbqH4npLKRvA3AjnacR3tTL8aypsep+On7
         TTGGD5Ljqs5AWoVQulqRmz4S7GHwtBVRYf7LfwuE=
Date:   Thu, 10 Sep 2020 13:16:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, SW_Drivers <SW_Drivers@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Omer Shpigelman <oshpigelman@habana.ai>
Subject: Re: [PATCH 12/15] habanalabs/gaudi: add debugfs entries for the NIC
Message-ID: <20200910131629.65b3e02c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAFCwf113A_=da2fGxgMbq_V0OcHsxdp5MpfHiUfeew+gEdnjaQ@mail.gmail.com>
References: <20200910161126.30948-1-oded.gabbay@gmail.com>
        <20200910161126.30948-13-oded.gabbay@gmail.com>
        <20200910130138.6d595527@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CAFCwf113A_=da2fGxgMbq_V0OcHsxdp5MpfHiUfeew+gEdnjaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 23:10:47 +0300 Oded Gabbay wrote:
> On Thu, Sep 10, 2020 at 11:01 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 10 Sep 2020 19:11:23 +0300 Oded Gabbay wrote:  
> > > From: Omer Shpigelman <oshpigelman@habana.ai>
> > >
> > > Add several debugfs entries to help us debug the NIC engines and ports and
> > > also the communication layer of the DL training application that use them.
> > >
> > > There are eight new entries. Detailed description is in the documentation
> > > file but here is a summary:
> > >
> > > - nic_mac_loopback: enable mac loopback mode per port
> > > - nic_ports_status: print physical connection status per port
> > > - nic_pcs_fail_time_frame: configure windows size for measuring pcs
> > >                            failures
> > > - nic_pcs_fail_threshold: configure pcs failures threshold for
> > >                           reconfiguring the link
> > > - nic_pam4_tx_taps: configure PAM4 TX taps
> > > - nic_polarity: configure polarity for NIC port lanes
> > > - nic_check_link: configure whether to check the PCS link periodically
> > > - nic_phy_auto_neg_lpbk: enable PHY auto-negotiation loopback
> > >
> > > Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> > > Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>  
> >
> > debugfs configuration interfaces are not acceptable in netdev.  
> 
> no problem, but can we have only these two entries:
> > - nic_mac_loopback: enable mac loopback mode per port
> > - nic_ports_status: print physical connection status per port  
> 
> nic_ports_status is print only (not configuration).

Doesn't seem like this one shows any more information than can be
queried with ethtool, right?

> nic_mac_loopback
> is to set a port to loopback mode and out of it. It's not really
> configuration but rather a mode change.

What is this loopback for? Testing?
