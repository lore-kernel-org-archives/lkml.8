Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78371C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A72B20747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFKMph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:45:37 -0400
Received: from hs2.cadns.ca ([149.56.24.197]:31442 "EHLO hs2.cadns.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgFKMph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:45:37 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jun 2020 08:45:37 EDT
Received: from [192.168.0.20] (135-23-114-58.cpe.pppoe.ca [135.23.114.58])
        by hs2.cadns.ca (Postfix) with ESMTPSA id AB4F914931;
        Wed, 10 Jun 2020 18:29:52 -0400 (EDT)
Authentication-Results: hs2.cadns.ca;
        spf=pass (sender IP is 135.23.114.58) smtp.mailfrom=sriram.chadalavada@mindleap.ca smtp.helo=[192.168.0.20]
Received-SPF: pass (hs2.cadns.ca: connection is authenticated)
From:   Sriram Chadalavada <sriram.chadalavada@mindleap.ca>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Feedback on Marvell 6176 DSA switch device tree and driver module code
Message-ID: <ee82e878-3337-c760-bd16-d5bcb9dbfa19@mindleap.ca>
Date:   Wed, 10 Jun 2020 18:29:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-PPP-Message-ID: <20200610222952.4822.29209@hs2.cadns.ca>
X-PPP-Vhost: mindleap.ca
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a detailed overview of what I have been grappling with:

https://stackoverflow.com/questions/62311589/feedback-on-marvell-6176-dsa-switch-device-tree-and-driver-module-code

I also tried a version of the device tree where the mdio device is in 
the dts file without being a subnode of the pci node. With that, the 
kernel doesn't crash but igb based eth0 and ports on the 6176 switch are 
NOT enumerated.

Thanks,

Sriram

