Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22B0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F518206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgIKKQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:16:35 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:53700 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbgIKKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:16:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B249D100E7B42;
        Fri, 11 Sep 2020 10:16:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shelf69_5d05263270ed
X-Filterd-Recvd-Size: 1890
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Sep 2020 10:16:29 +0000 (UTC)
Message-ID: <7e513eea8ecf7ff1379d7a87245915469784121c.camel@perches.com>
Subject: Re: MAINTAINERS: Marking internal distribution lists
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Date:   Fri, 11 Sep 2020 03:16:28 -0700
In-Reply-To: <alpine.DEB.2.21.2009110811520.9220@felia>
References: <alpine.DEB.2.21.2009110811520.9220@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-11 at 08:37 +0200, Lukas Bulwahn wrote:
> Hi Joe,
> 
> in my continued effort to clean up MAINTAINERS, I came across various 
> email "lists" that are actually just some kind of internal distribution
> lists, but we cannot subscribe to them (no archives available) and they 
> are not affiliated to a specific person.
> 
> Some examples are:
> 
>   - bcm-kernel-feedback-list.broadcom.com
>   - brcm80211-dev-list.cypress.com
>   - brcm80211-dev-list.pdl.broadcom.com
>   - coreteam.netfilter.org
>   - esc.storagedev.microsemi.com
>   - linux-imx.nxp.com
>   - megaraidlinux.pdl.broadcom.com
>   - MPT-FusionLinux.pdl.broadcom.com
>   - ocfs2-devel.oss.oracle.com
>   - oss-drivers.netronome.com
>   - patches.opensource.cirrus.com
>   - qat-linux.intel.com
>   - rds-devel.oss.oracle.com
>   - sparmaintainer.unisys.com
>   - wil6210.qti.qualcomm.com
>   - x86.kernel.org

At one time, those sorts of email addresses were called "exploders"

Perhaps mark them as such?
Maybe like:

L:	megaraidlinux.pdl@broadcom.com (exploder for non-subscribers)


