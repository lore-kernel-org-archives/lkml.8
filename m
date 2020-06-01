Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EA7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4D52072E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="F4Ds2cxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgFBACx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:02:53 -0400
Received: from ms11p00im-qufo17291601.me.com ([17.58.38.45]:48254 "EHLO
        ms11p00im-qufo17291601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbgFBACx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:02:53 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 20:02:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1591055709;
        bh=gORcQ5eR+p0+qNP4l53yvket3NwncOkPtSbaOdqaovo=;
        h=Content-Type:Subject:To:From:Date:Message-Id;
        b=F4Ds2cxai9Mm5c0Gf850XIXvrViYRxYn9eYUdcgAtujPotq7RIBikVRKlM8LxeFfV
         Obn/DRvIjZohDI2asZALMUW4Ud0//hscTTQSuUI3Emvploh0jPOZXEVRIf0t9ijiYm
         jesx8Ahr21540Gpf8AgpSuvk/y9VWlJcvYqhF8F5jCIfSsvl7+oaAL83bhIEck/0s8
         AeMnBXqt1OwxvQ3AoLMqp0SLOY5/eMaQNpv6Klr7c1Pc5D+FrD+/+DaFefYe+o/2vG
         yALpt2TdfEHshK9MfkTf/pUoZPevyCGuDMWUYUyZ9T+PxmCbRTtefoy0UWWupYhIAY
         BOyip37broUrw==
Received: from [192.168.1.102] (c-73-3-232-112.hsd1.co.comcast.net [73.3.232.112])
        by ms11p00im-qufo17291601.me.com (Postfix) with ESMTPSA id DF69220027C;
        Mon,  1 Jun 2020 23:55:08 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (1.0)
Subject: Ethan
To:     linux-kernel@vger.kernel.org
X-Universally-Unique-Identifier: 76485908-29B7-420A-8A27-2D3A894CFD7F
From:   Ethan Oquist <ethanoquist@icloud.com>
Date:   Mon, 1 Jun 2020 17:55:06 -0600
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <54D8917B-81A1-4635-9887-41B4B97E935B@icloud.com>
X-Apple-Notify-Thread: NO
X-Mailer: iPad Mail (17E262)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-01_12:2020-06-01,2020-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=482 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2002250000 definitions=main-2006010176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Sent from my iPad
