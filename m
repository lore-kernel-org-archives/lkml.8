Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2386C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C8C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="l35Edr8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBLDXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:23:17 -0500
Received: from scoopta.email ([198.58.106.30]:35058 "EHLO scoopta.email"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbgBLDXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:23:17 -0500
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 22:23:16 EST
DKIM-Signature: a=rsa-sha256; b=l35Edr8f14bRCsWAzZzOrVlarLPsbcBl4f6j9Ip/9xcJPb+J+U4ymAGErXx5K/G9qFdHyWJrLHvBDcqNxCESF6/z1K8+YrA3M8+tiw1ylf7rQCe1Jb1QeoRBEtP8aAjn+1+FHUEm7xU0Ls5Qan0aHbkTXBDRdecdFEybKFpNF07lVpG2Uw0oF1h5XUIm/H9HVeIjURo8yolo86Ekm4TjMTa5lmEHFypFIKOngZReJJK5LkWCZjKbF3AVw8Ur1Iyk8f0Q4wF+9R6SUhA6ETEiM8Jkbrh9VvzIOL2Kw+heApsKuUxoeajEfILOnzwiY3+9/I3xshCdB9VB007d++qTo2J+5O3/JFw3ENbW7kBX/J392GUfyV7txUHYHDV5RRER7zhoEekSV67dhYqRE+dNLqCArhXOZK9Kg8w+Q0iZMa4P3NSzNKkAr2c6sdp6nwaZDmvnIx1ywL3BTJxpEDswzY7Mv2OPI8faestjjKwFapiPa7kYJeM7/0uKz9XV/9FnvBH5n4LKTo50WHkaAbPs10T+vhYE/Wf9z5QHcel/PtqkmZLi6q5Z8GVpY4Y31sdqk8yy43UhFoBvjrbqeN+YtL2VFfrC/caoaqPl3ZMWV9gXkkj/lNU5YY1+69R1YROs0zQ+0+FuuR5V+tm0T8zAEUKyFp4YnLqoyP1Ng9YD28b6pjYklURGEV2STXKFTLlX8SWfM/tRJBRjEe/8ND/u8JMYsSnNmNwNkhwM5jt950VHB492wv88HrPimsx6pKgxclQLv/pewC7QPIM6dnJLq6mn12fnKZ2o4wu17nKER9AcPUFHP+6VPn6l1mxEkpExHdUnR2QHY+x7kSCl/w1dw2Hj1NVC4k1bjcEewczGVRbsyZ0ejCujjXmy+R6jRlQtoi/p2J/kzqEDweb7fjXhm8VipSVw1xAFzPSQ5AGJwdYiWtha40pFQZAdt999pBNz6W0R5/
 h5dADvoJSh5gFiopBSEB6WZh2f13cM/+E08YJg4On5Lo8Ge2y3fDMWqsodDs5l5D7MSQpg1/zrXJjrpRoGWi1ln5nGVTXkgmArn14Fly+W86h0rnJsOOzvW6FWQ5zuLjO/qh2p4zW0DSSbZqsz33cthVgyMWxye7on9sF4sW5k70WL4jttFo++KSCqoRCe1Lf4xd0f9IQq7jLPFHh1+hn9idlqiu1Ul0pFuhT4e28ktmeZKp+J9ZzzD4O1GDQGTeB/jhOHXclapjt8pt+We8dpJAUuEzQ541JRnn9Ic1+Rl+YuMRgSIjCOYQmVLMKwagbdlMDAycSpOy46c8VvWFpH26eQVONQILwmpq/DH6XVAEVwcdq/kvppiPLdHfBWyusTFHEs5SA1CjOUAg==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=HZZOqhv2dax/2TCAyXa+ed6N05ltomfM1ZgKrEujBLA=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2600:1700:4810:f9ef:0:0:f0c5:cafe (EHLO [IPv6:2600:1700:4810:f9ef::f0c5:cafe]) ([2600:1700:4810:f9ef:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID 1759566365
          for <linux-kernel@vger.kernel.org>;
          Tue, 11 Feb 2020 19:13:06 -0800 (PST)
To:     linux-kernel@vger.kernel.org
From:   Scoopta <mlist@scoopta.email>
Subject: RX 5700 XT Issues
Message-ID: <8e09f86e-b241-971a-ea8c-8948b9e06d20@scoopta.email>
Date:   Tue, 11 Feb 2020 19:13:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When playing demanding games my RX 5700 XT will sometimes just stop. All
my displays turn off but the system stays responsive. Audio keeps
working and I can REISUB no problem, the card just stops. Fans turn off
lm-sensors reports N/A as all information on the sensors and my monitors
go into power save. syslog is also completely quiet. amdgpu doesn't seem
to error or anything so I have no idea how to troubleshoot if this is a
hardware issue or if it's a driver issue. I couldn't find a drm or GPU
specific list so I'm sending it here. I want to be sure it's not a
driver issue or other kernel issue before doing an RMA.

