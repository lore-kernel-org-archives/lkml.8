Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A89C43462
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D832075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgG0JHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:07:16 -0400
Received: from mailout02.rmx.de ([62.245.148.41]:50044 "EHLO mailout02.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgG0JHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:07:14 -0400
X-Greylist: delayed 1975 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 05:07:13 EDT
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout02.rmx.de (Postfix) with ESMTPS id 4BFY4k3XJ8zNmS0;
        Mon, 27 Jul 2020 10:34:14 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BFY4P5jZxz2xDy;
        Mon, 27 Jul 2020 10:33:57 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.102) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 27 Jul
 2020 10:33:44 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Hering <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Richard Leitner" <richard.leitner@skidata.com>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ceggers@arri.de>
Subject: [PATCH v3] Add two new configuration drivers for Microchip USB hubs
Date:   Mon, 27 Jul 2020 10:33:29 +0200
Message-ID: <20200727083333.19623-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726084116.GD448215@kroah.com>
References: <20200726084116.GD448215@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.102]
X-RMX-ID: 20200727-103403-4BFY4P5jZxz2xDy-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonday, greg k-h wrote:
> Please resend the whole series, not just a single patch, as it makes it
> very difficult to pick the "correct" patches to be applied...

Changes in v3:
 - none (only resend the whole series)

Changes in v2:
 - added property description for ocs-min-width-ms
 - fixed property description for oc-delay-ns



