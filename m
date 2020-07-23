Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10CCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24C520709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWAuYbDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgGWOT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:19:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgGWOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595513966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TPxJ6ecRZcUkmgqLd9QvSwuf9V9UOaIvEHGPITh1SwI=;
        b=VWAuYbDKvbf6ismsN/4I9KJXw8OFLzhVTaP+YI59Y3yI9T565CHszyxmnyIj5WOjwsWtZn
        eEakjIUtfHIy6MVMv/Xy9dmPkcSQUkkhX6jguCnqujLfE1iRM/e0bGSMR1dZFEeYyVztMu
        YDQRYsf684E3rNoU8rj39V3drjMYYLk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-THjrZACpPh2jNwxSa_CXDA-1; Thu, 23 Jul 2020 10:19:24 -0400
X-MC-Unique: THjrZACpPh2jNwxSa_CXDA-1
Received: by mail-qv1-f70.google.com with SMTP id g17so3690179qvw.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TPxJ6ecRZcUkmgqLd9QvSwuf9V9UOaIvEHGPITh1SwI=;
        b=toRu/EMe6o1BHa3yfXHF/jvlJ15Wcpptzdl4frX1dBuESVpi6UwHkGLi3UfKH21pW+
         QLwZUzQT4qetjatru7/hEwIO1XAfPfI7qNI1oooObTnfMUnmPAgcYRc7tkxOEIgQZn9y
         wvofzin8h4OOA/J3Zz6yHKITT8xn6WQztP/EGMBrE+3yQP2juJDsquOkjfzzr+TSumDg
         w6xJPVFDzjJairka3rFPbGRSV517NdGTNff9TasRkwWOK3LKJLlkei5QLo856T6UI6/p
         FAukaz07xn2xxK/q6lTxKaB2bvhScu0Fr7566SoPnfvmT1Iwc5TDaPTJ1lRHKNKGMqIl
         wCEA==
X-Gm-Message-State: AOAM530Gajc0i18uxcjrsQC9jwrZ4KfbcDzOCiwqRkpya0wpnDa6b+8G
        jR9LZsXReZjrjlqi2J/XP6PWHHN5nR0j9stnx62rYb5BoYkiU0bsxMII8MLZ7QXYeaig6foiuHw
        AjoDDLoMIsOhruM30vL3pxCgI
X-Received: by 2002:ae9:dd41:: with SMTP id r62mr5425025qkf.327.1595513964241;
        Thu, 23 Jul 2020 07:19:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyor/sEuJ1ILiUvnXH2q/LutcM92n90ckKA+iXLKs3Ks/I7zdfJPzXs5YbSaHWhsPNDMTwjrA==
X-Received: by 2002:ae9:dd41:: with SMTP id r62mr5424974qkf.327.1595513963870;
        Thu, 23 Jul 2020 07:19:23 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j9sm2626609qtr.60.2020.07.23.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 07:19:23 -0700 (PDT)
From:   trix@redhat.com
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        masahiroy@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org,
        akpm@linux-foundation.org, will@kernel.org, krzk@kernel.org,
        patrick.bellasi@arm.com, dhowells@redhat.com,
        ebiederm@xmission.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] bpf: BPF_SYSCALL depends INET
Date:   Thu, 23 Jul 2020 07:19:14 -0700
Message-Id: <20200723141914.20722-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A link error

kernel/bpf/net_namespace.o: In function `bpf_netns_link_release':
net_namespace.c: undefined reference to `bpf_sk_lookup_enabled'

bpf_sk_lookup_enabled is defined with INET
net_namespace is controlled by BPF_SYSCALL

So add a depends on INET to BPF_SYSCALL

Signed-off-by: Tom Rix <trix@redhat.com>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 7b8ef43e7fb4..817f70e6023c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1663,6 +1663,7 @@ config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
 	select IRQ_WORK
+	depends on INET
 	default n
 	help
 	  Enable the bpf() system call that allows to manipulate eBPF
-- 
2.18.1

