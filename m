Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C21C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDA32078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="VPAcboqR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="ean5dyqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgFMWgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:36:17 -0400
Received: from smtp.uniroma2.it ([160.80.6.16]:41795 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFMWgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:36:16 -0400
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 05DMZxuG019259;
        Sun, 14 Jun 2020 00:36:04 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
        by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 7B69212093E;
        Sun, 14 Jun 2020 00:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
        s=ed201904; t=1592087755; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsxSNSWu5WD8jMh67/fRBqZEczfqOOR6ef+YVsRr9WY=;
        b=VPAcboqRmMNleJACcpdM1QYqhnF4kvR/lSDmChodPo4fFw3MR0kWNgM7z1Bu/rOPJG8y7c
        dUwiVb7ALY7aE+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
        t=1592087755; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsxSNSWu5WD8jMh67/fRBqZEczfqOOR6ef+YVsRr9WY=;
        b=ean5dyqRTvryl0C/DnYRYjcPoqJodQHoy2hlrjz7bwF/ymZa3W9SVBQPG5LRTOQMNuInPe
        lzD6eqH+JSh9rObufD3lr0mEwivDUupUzkKEkRBWkE+kuOB0uY6xSVM7ntgXAs6Ng4yQmi
        QltbM95WeAnT2AHhK/yi3w1TtPSXY2I7HpkL1IVnWIjgBV12I9CUbfKDuJKf/RpqWLRa8o
        7xl7MOxwyMxOFzUNKibFffD16Fa435/RgVT8x3aESR/k6EApD1k/2F19Z8Yf9EsylleYwB
        bQXElNccPltGiCPtLVhOu91asE8hRSgPBi402xKqtIJhGc+t/vFjB+84Bp5B6w==
Date:   Sun, 14 Jun 2020 00:35:54 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrea Mayer <andrea.mayer@uniroma2.it>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Donald Sharp <sharpd@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Dinesh Dutt <didutt@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Ahmed Abdelsalam <ahabdels@gmail.com>
Subject: Re: [RFC,net-next, 1/5] l3mdev: add infrastructure for table to VRF
 mapping
Message-Id: <20200614003554.4bfed8a61a5741bfd2660d30@uniroma2.it>
In-Reply-To: <20200612105148.1b977dc3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200612164937.5468-1-andrea.mayer@uniroma2.it>
        <20200612164937.5468-2-andrea.mayer@uniroma2.it>
        <20200612105148.1b977dc3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 10:51:48 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> net/l3mdev/l3mdev.c:12:1: warning: symbol 'l3mdev_lock' was not declared. Should it be static?
> 
> Please make sure it doesn't add errors with W=1 C=1 :)

Hi Jakub,
thanks for your feedback.

sorry, I did not want to add more warnings! I will declare the l3mdev_lock
static! I will be more careful while checking with W=1 and C=1 next time.

Thanks,
Andrea
