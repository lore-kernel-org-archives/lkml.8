Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ADEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A7520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg92RMsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgA3TKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:10:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727681AbgA3TKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580411436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SUtSFdT+kYmI8Bo8IponmuE6vaTB5AiudIIi8xyUiPM=;
        b=fg92RMsbHHLhjkNsqU9PHB9FpdCywI6BBx8dTxZp1OJHIiwh6oVcoUthiHpF3gau63jCbx
        vLmaoH/SHMC5CYZHkd1/z+ma7bYzwVlDniAz7aim+dUxJWKMvnee1Qi6Eh/8hcQoXb5R3J
        udS41RkK4PRZt7zadQowf8ffb9EFdg8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-GdbeM0BeOZ6bd0cr4U4A9w-1; Thu, 30 Jan 2020 14:10:34 -0500
X-MC-Unique: GdbeM0BeOZ6bd0cr4U4A9w-1
Received: by mail-wm1-f70.google.com with SMTP id m18so1285487wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SUtSFdT+kYmI8Bo8IponmuE6vaTB5AiudIIi8xyUiPM=;
        b=sRlKxMPT+fKfBPgp5EWneUfNDzwjWHRn8/xLqDH7uiDNnn9Uqrgwy7IPesY7hiOgoZ
         ki2vvq9F8quXxbdlpMwLpUbDIw5RJWKYJNUkqGSvv7afI9vI8AKrsnCHJ/dIDIG3JRK/
         vjEsc7yfcXs3opvEKea4qbJUzjgfZpYaJOB65QtsGrZ8HLHAqw4kL1m9bgFSs3VCQJb2
         30IX2zU6EN/1U82bMbvBinDPRKznehUZEstB2LnsUzaMgDi3bpepvn4rHJCNSGfFC3iD
         fTiOeKA4hks/q+HNvwWiBTKg1fKHmjvL2dHyw1D90DaIHdpVm78qJlfm/nxe4sSBzKaO
         hqhQ==
X-Gm-Message-State: APjAAAUDageyKP84B3LzY4B5oQfcVpBIXKdz/A7Kk6ZPcPCgPCcdYEOe
        ywiAzeJ3fk5M0DtsxBSDENlFVmwI0WW0skKhfsRXWkIgitap9BXtllHZ1CN17T0VCEKCUGEsUhS
        Kzt6q7bVR5OA8rbMMsV9gJicE
X-Received: by 2002:a5d:6708:: with SMTP id o8mr7467577wru.296.1580411433136;
        Thu, 30 Jan 2020 11:10:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqwd2K5FNDKGZYqIaB7n3fgbnyN9C2V+AsRZ0esnHsarDmz4aw6MjM7UxxTdj8JoUalHG+ySGg==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr7467555wru.296.1580411432866;
        Thu, 30 Jan 2020 11:10:32 -0800 (PST)
Received: from turbo.redhat.com (net-2-36-173-233.cust.vodafonedsl.it. [2.36.173.233])
        by smtp.gmail.com with ESMTPSA id s139sm7794275wme.35.2020.01.30.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 11:10:32 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org
Subject: [PATCH net] netfilter: nf_flowtable: fix documentation
Date:   Thu, 30 Jan 2020 20:10:19 +0100
Message-Id: <20200130191019.19440-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the flowtable documentation there is a missing semicolon, the command
as is would give this error:

    nftables.conf:5:27-33: Error: syntax error, unexpected devices, expecting newline or semicolon
                    hook ingress priority 0 devices = { br0, pppoe-data };
                                            ^^^^^^^
    nftables.conf:4:12-13: Error: invalid hook (null)
            flowtable ft {
                      ^^

Fixes: 19b351f16fd9 ("netfilter: add flowtable documentation")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 Documentation/networking/nf_flowtable.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/nf_flowtable.txt b/Documentation/networking/nf_flowtable.txt
index ca2136c76042..0bf32d1121be 100644
--- a/Documentation/networking/nf_flowtable.txt
+++ b/Documentation/networking/nf_flowtable.txt
@@ -76,7 +76,7 @@ flowtable and add one rule to your forward chain.
 
         table inet x {
 		flowtable f {
-			hook ingress priority 0 devices = { eth0, eth1 };
+			hook ingress priority 0; devices = { eth0, eth1 };
 		}
                 chain y {
                         type filter hook forward priority 0; policy accept;
-- 
2.24.1

