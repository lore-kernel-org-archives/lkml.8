Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFBEC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF6D2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvHOEg6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCWFfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:35:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38181 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgCWFfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:35:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so15366847wrv.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=48qkqxYGNTDT4PSF+80i7p8bQweaG9a4WqU/RKeDBq0=;
        b=HvHOEg6bjFJZoPMKPOmc7fwaVV2PDx1Ej1qXD4A4KcfoHT4syJkL251SH4ddfaSJay
         LPG6C91roOJSUvy0ke+r7pFnsOYGJ07pHwVSYGbZBje3Pn/j+Eqo4r5KbfG7ddlkDr8X
         XXe21LX8S9C4hlWgexmfve42E6GH+e9sbTpqE3kVe23+MBRpEYLR4OX2kr6FWTObvxJ0
         5URCx0Xc83wMqefkAMRfk4fJHl1qFA5HMp3x4hPzWGme60NBZLkNguorjZv8XTEu2Zta
         xvWzY4CFtu3/pI59o8w3UutM5Ex/oEe8SYq9ltKHJfTHz30uUeuS73UfE0jWqbSLSJWo
         Uptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=48qkqxYGNTDT4PSF+80i7p8bQweaG9a4WqU/RKeDBq0=;
        b=nG4e50Ib4oZVMQkcoFOlJ5jD2VBZ13d3UG6oIEGNTq3ET6i3ABD+CB/jvxACV7f+IL
         SBke3SfEvKhvv1fInBRJQhftRU9T+fEp7Vl+hRgGcEGhVITPgdqsbjLOJdPf54TmK0UF
         oOrglY6vHfBzZytPI0geb9mvaJu8FUIbsryP7AkoiIpd/9qnyRDfI6KCU9FiL0F0yVo5
         dLTAO9mFTOEIA3VyAlI9bgZ+96H6yMs/U43iBlXQb504CVX8H6pl1C79a8Z8BDgIpoHM
         yHh8cOmY5F/xDU53bACPZBYocJnmHZBRDNFCU+sGdpDGchRkjGnKENYMsp4mT0ojwVt3
         OnFg==
X-Gm-Message-State: ANhLgQ2wxnD3GnNWtpl4qT1WK6cs6aSfETd9R/RZy6iAAfHeXL+cPi2x
        /pebeSuUpbXV4hUBDBbhV20=
X-Google-Smtp-Source: ADFU+vtxXvjXEAlDtqjeAJ71CW/iwYi4dJYF2EK/ocEUKGF4ITV9b2s0pUjEdrnOwB6r7yU2RMkscQ==
X-Received: by 2002:adf:9ccb:: with SMTP id h11mr7645800wre.22.1584941706626;
        Sun, 22 Mar 2020 22:35:06 -0700 (PDT)
Received: from kbp1-lhp-F74019 (a81-14-236-68.net-htp.de. [81.14.236.68])
        by smtp.gmail.com with ESMTPSA id z129sm19935999wmb.7.2020.03.22.22.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 22:35:06 -0700 (PDT)
Date:   Mon, 23 Mar 2020 07:35:03 +0200
From:   Yan Yankovskyi <yyankovskyi@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [Xen-devel] [PATCH 2/2] evtchn: Change evtchn port type to
 evtchn_port_t
Message-ID: <20200323053503.GA1406@kbp1-lhp-F74019>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct evtchn_set_priority uses uint32_t type for event channel port.
Replace the type with evtchn_port_t. Such change is also done in Linux.

Signed-off-by: Yan Yankovskyi <yyankovskyi@gmail.com>
---
 xen/include/public/event_channel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xen/include/public/event_channel.h b/xen/include/public/event_channel.h
index 44c549dd6b..cfb7929fef 100644
--- a/xen/include/public/event_channel.h
+++ b/xen/include/public/event_channel.h
@@ -307,7 +307,7 @@ typedef struct evtchn_expand_array evtchn_expand_array_t;
  */
 struct evtchn_set_priority {
     /* IN parameters. */
-    uint32_t port;
+    evtchn_port_t port;
     uint32_t priority;
 };
 typedef struct evtchn_set_priority evtchn_set_priority_t;
-- 
2.17.1

