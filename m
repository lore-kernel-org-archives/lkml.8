Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0811FC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86D3206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFpxKJXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgHaDYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgHaDYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:24:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0168AC061573;
        Sun, 30 Aug 2020 20:24:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j11so2362050plk.9;
        Sun, 30 Aug 2020 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaME3Z5uLAfT5ND31CqQyrNIC7MORGaQXez8ygNaWV4=;
        b=fFpxKJXxV+7xKRjCzTY6PbcZAwSAX914tKm+/3hUeRDb8l9NGtIt8tyVKrYGCJJygK
         kStyp0mmA4YJ1Q5CqAnAMHeljr1gxyTnLbIeW8T1O0wgenniJqDoBiVhX4hOxvGNUBQ4
         d0T7WVuy4dvNEH4ZkHE2fNbctdGRxO9TlVbAyWR9Or5Y23fv86W/uSLp1NLgmVZLVkt2
         qVpH2h6rZA4KT5iI6dHASILlZaOQeVYg0JoUrgaZKlHe2MYfupxf8r9ajQ5oao93kmHa
         1ItBd3Odis6uFe6GzL0Xpktjj9KYIKg3F2RsXOVPYwhgmOnmmj0/lXC2BP3D0//uLd6P
         7Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaME3Z5uLAfT5ND31CqQyrNIC7MORGaQXez8ygNaWV4=;
        b=ON2wN1L9SSUESSIG+O0eNucA4XbMr5eEZpBSU93hJmX2s7tCKeHvlT+iardfNETA5I
         nFJmiK0RajuHACAGktyBr5kUTr2AX/I2eCx6i4mo9T0UeNlPXVRVnhOJ0aiDkCPVnKx9
         5XzhJAU4+gLlEiG9h7wgZYpaUF1MiSVfsBt5Okb+x4yAXGknfkmalde+CuB4GqxdBivF
         QirTaXog3g1Cns9th4ep3dBzq12L1hoz0xp0eHNQDkontYWijzkR/vPsjOEo9Eq1snfe
         +JjR7qZCCfr0anjHsSQLAitBHC6i4sCs2Li1VvRLk27nts+jf2Uy1qWaSsUqwKw5BxNR
         ATPA==
X-Gm-Message-State: AOAM533uF+RaAPJYQa1Di2m8ERd0h4eZJBLKibI7AA/8JHMpMgmDLZm8
        F8HFm3Jyay8tgsGypklxn6AVtkw9Ztk=
X-Google-Smtp-Source: ABdhPJyfajy5gmszwFXi74/g2PDTsuNU+sdcVI1BZbIifxrztt/VVyU4XTGfzc/GUsJ6wnFfRHAmSw==
X-Received: by 2002:a17:90a:c505:: with SMTP id k5mr8560680pjt.188.1598844284116;
        Sun, 30 Aug 2020 20:24:44 -0700 (PDT)
Received: from sol.lan (106-69-184-100.dyn.iinet.net.au. [106.69.184.100])
        by smtp.gmail.com with ESMTPSA id z17sm6095733pfq.38.2020.08.30.20.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 20:24:43 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v6 20/20] tools: gpio: add debounce support to gpio-event-mon
Date:   Mon, 31 Aug 2020 11:20:06 +0800
Message-Id: <20200831032006.1019978-21-warthog618@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831032006.1019978-1-warthog618@gmail.com>
References: <20200831032006.1019978-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for debouncing monitored lines to gpio-event-mon.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/gpio/gpio-event-mon.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/gpio/gpio-event-mon.c b/tools/gpio/gpio-event-mon.c
index e50bb107ea3a..bd5ea3cc6e85 100644
--- a/tools/gpio/gpio-event-mon.c
+++ b/tools/gpio/gpio-event-mon.c
@@ -148,11 +148,12 @@ void print_usage(void)
 		"  -s         Set line as open source\n"
 		"  -r         Listen for rising edges\n"
 		"  -f         Listen for falling edges\n"
+		"  -b <n>     Debounce the line with period n microseconds\n"
 		" [-c <n>]    Do <n> loops (optional, infinite loop if not stated)\n"
 		"  -?         This helptext\n"
 		"\n"
 		"Example:\n"
-		"gpio-event-mon -n gpiochip0 -o 4 -r -f\n"
+		"gpio-event-mon -n gpiochip0 -o 4 -r -f -b 10000\n"
 	);
 }
 
@@ -167,11 +168,12 @@ int main(int argc, char **argv)
 	unsigned int num_lines = 0;
 	unsigned int loops = 0;
 	struct gpio_v2_line_config config;
-	int c;
+	int c, attr, i;
+	unsigned long debounce_period = 0;
 
 	memset(&config, 0, sizeof(config));
 	config.flags = GPIO_V2_LINE_FLAG_INPUT;
-	while ((c = getopt(argc, argv, "c:n:o:dsrf?")) != -1) {
+	while ((c = getopt(argc, argv, "c:n:o:b:dsrf?")) != -1) {
 		switch (c) {
 		case 'c':
 			loops = strtoul(optarg, NULL, 10);
@@ -187,6 +189,9 @@ int main(int argc, char **argv)
 			lines[num_lines] = strtoul(optarg, NULL, 10);
 			num_lines++;
 			break;
+		case 'b':
+			debounce_period = strtoul(optarg, NULL, 10);
+			break;
 		case 'd':
 			config.flags |= GPIO_V2_LINE_FLAG_OPEN_DRAIN;
 			break;
@@ -205,6 +210,15 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (debounce_period) {
+		attr = config.num_attrs;
+		config.num_attrs++;
+		for (i = 0; i < num_lines; i++)
+			gpiotools_set_bit(&config.attrs[attr].mask, i);
+		config.attrs[attr].attr.id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
+		config.attrs[attr].attr.debounce_period = debounce_period;
+	}
+
 	if (!device_name || num_lines == 0) {
 		print_usage();
 		return -1;
-- 
2.28.0

