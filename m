Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67335C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452242070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596025808;
	bh=5gdtqyYzHNXUduyS3z6Fo+0DDu3Naabec0c2Ib17zHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=kZ8LoyslIVrjOElMomA5xgLl+WKsU1lPucAy1XeNMsH/gOZOHdALqesP4+xdLl+sM
	 lEgITAqZECmiA/PQcq8c152j4hvIfIQ9tprDpjCNAJb82O69N1TpFUtQL73HX/lMQw
	 43NYJMc/+Oo42RItLau2VIvwieCnf5Ef/g2pJoq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgG2MaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2MaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:30:04 -0400
Received: from localhost (unknown [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD562070B;
        Wed, 29 Jul 2020 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596025804;
        bh=5gdtqyYzHNXUduyS3z6Fo+0DDu3Naabec0c2Ib17zHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EiLcXo4hnqx4SVOp3nLa2QptpSC6bi46vKjrpt5NPK3l0Wsjs4XOeBNeL/YR6Np69
         w2WjOjcqTT8xxQV+08q4BZSbVKJ6YS5QsBbqdH0siXw07EwYYu52GKiTKLMpwNZwv0
         FJVtFbjbepPQv93Zol3/MdTF3A626eZvEAvmmjqU=
Date:   Wed, 29 Jul 2020 07:29:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kevin Curtis <kevin.curtis@farsite.co.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1] farsync: use generic power management
Message-ID: <20200729122954.GA1920458@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729101730.GA215923@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:47:30PM +0530, Vaibhav Gupta wrote:
> On Tue, Jul 28, 2020 at 03:04:13PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2020 at 09:58:10AM +0530, Vaibhav Gupta wrote:
> > > The .suspend() and .resume() callbacks are not defined for this driver.
> > > Still, their power management structure follows the legacy framework. To
> > > bring it under the generic framework, simply remove the binding of
> > > callbacks from "struct pci_driver".
> > 
> > FWIW, this commit log is slightly misleading because .suspend and
> > .resume are NULL by default, so this patch actually is a complete
> > no-op as far as code generation is concerned.
> > 
> > This change is worthwhile because it simplifies the code a little, but
> > it doesn't convert the driver from legacy to generic power management.
> > This driver doesn't supply a .pm structure, so it doesn't seem to do
> > *any* power management.
>
> Agreed. Actually, as their presence only causes PCI core to call
> pci_legacy_suspend/resume() for them, I thought that after removing
> the binding from "struct pci_driver", this driver qualifies to be
> grouped under genric framework, so used "use generic power
> management" for the heading.
> 
> I should have written "remove legacy bindning".

This removed the *mention* of fst_driver.suspend and fst_driver.resume,
which is important because we want to eventually remove those members
completely from struct pci_driver.

But fst_driver.suspend and fst_driver.resume *exist* before and after
this patch, and they're initialized to zero before and after this
patch.

Since they were zero before, and they're still zero after this patch,
the PCI core doesn't call pci_legacy_suspend/resume().  This patch
doesn't change that at all.

> But David has applied the patch, should I send a v2 or fix to update
> message?

No, I don't think David updates patches after he's applied them.  But
if the situation comes up again, you'll know how to describe it :)

Bjorn
