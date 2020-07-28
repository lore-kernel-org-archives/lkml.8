Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2D7C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF5A2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595951547;
	bh=mZZmNoIYDscWYVG7Tsp6OFcYCYHfyCf6/B6uaMCIWds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0ojBmDMftkWqQlPG/Y93PY0U2VZaa4ToULfzuplTYIAiK9JKZf7slp7yzzM8S5vLe
	 jW3EdwdeITXxscjyVa1f7UySycAMyqNtql4D28TFjp1DXXQ5qu49vGJsILP6120X3O
	 HAmZKrLRrijkw9jeuZfnqMFdpSfJ1N+JNZQGbeYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgG1Pw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgG1Pw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:52:26 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44166206F5;
        Tue, 28 Jul 2020 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595951545;
        bh=mZZmNoIYDscWYVG7Tsp6OFcYCYHfyCf6/B6uaMCIWds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=muDU4b0rf8ALBv2GFGvqrU4QeqKSw3BxexW0J6eBBeKMUrkHp3YhZGEiVK70FohE9
         NsXNNE0ROP7UBpz4MHQvSfv8UkK3GcEkZ251CBr5QHJtFulY5KPRLEhhUVFbamlYOP
         rEPy7ALXtd4jumyXrpcNDCOa5oW2psxJAVeHSLmY=
Date:   Tue, 28 Jul 2020 08:52:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
Cc:     netdev@vger.kernel.org, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?B?T25kxZllag==?= Jirman <megous@megous.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next v4 0/2] Add support for LEDs on
 Marvell PHYs
Message-ID: <20200728085223.4eb34a8e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200728150530.28827-1-marek.behun@nic.cz>
References: <20200728150530.28827-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 17:05:28 +0200 Marek Beh=C3=BAn wrote:
> this is v4 of my RFC adding support for LEDs connected to Marvell PHYs.

FWIW a heads up for when you post a non-RFC version - neither patch
builds on allmodconfig right now.
