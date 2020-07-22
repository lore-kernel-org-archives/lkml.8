Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD81C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547EF2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbgGVTLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:11:45 -0400
Received: from mailout06.rmx.de ([94.199.90.92]:52874 "EHLO mailout06.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732575AbgGVTLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:11:44 -0400
X-Greylist: delayed 1923 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 15:11:43 EDT
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout06.rmx.de (Postfix) with ESMTPS id 4BBklZ1dR6z9yJT;
        Wed, 22 Jul 2020 20:39:38 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BBklC2LPTz2xDP;
        Wed, 22 Jul 2020 20:39:19 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.68) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 22 Jul
 2020 20:39:12 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add two new configuration drivers for Microchip USB hubs
Date:   Wed, 22 Jul 2020 20:38:55 +0200
Message-ID: <20200722183859.24470-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.68]
X-RMX-ID: 20200722-203923-4BBklC2LPTz2xDP-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most USB hub chips from Microchip can be configured via I2C/SMBus
interface. The series adds two new drivers for configuration of the
following USB hub series:

- USB253x
- USB3x13
- USB46x4
- USB47xx
- USB49xx


