Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4309EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1863320870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tggaKkj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbgCCUgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:36:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36445 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbgCCUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:36:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id g83so4306120wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JVXnb2RwSbPyr1ITMUSU2/qFrZVQ3Ak00T70C9cmiPo=;
        b=tggaKkj3Es06D0orD2nAg2LNo5AR1bKjlO6GzEZuuunYTYzR9VUdysvsGgjiN1fNz/
         2fs/eENLXDwnv9PeCZtgagy7vDzoTP0GRbgoBtrhv+o83xGXdpDV9d7RAShWLPHbqwd3
         pLZlN7VKyBuOIh/iGwr5f8NEf3MzsJhCvu3FOq0dlkJiCrUgkKKWA2sYazhXEAf5g1fu
         dJFL0+jFXyvfPoubAs3wAojYAI5J27QimpDBDhDfOKPrJNaChIL/NCz7FOJBSfcHzGCm
         Mgggcnsp6l1K8pUWZKmy9HYapH/szJY7SpmKHxquAwA8SFIgn//y+RX6YkycjF0FHkcS
         r6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JVXnb2RwSbPyr1ITMUSU2/qFrZVQ3Ak00T70C9cmiPo=;
        b=J/qreyC260hNl8ol1XexqClH65WsWZ+W1wQnLN9XlnZF7vlyM8G7YM2UZZcfXm66cW
         Od8N/XiW1HGa/Tmjd9xIU14Ao3pYmf42z+xduYeQZXs1OGqMHr40pl02b/LGP8ldyW91
         +ZYXG6Ujdu9DYOqeD4vPPxiuOAtKXE5F3YKCUQb8II56khGmTdrfY0aGCIuIIDH85sCW
         2p3BfhSHsZC2cNFXkPDThXi7MJxcnhRcNBgkyA6CPsFcTLWJcoPOJhOu3CpUuf+Z7yNV
         XdXzUVAcWOfJ947Suqkv238zIFmHv++ykeVUTJJlU7twimvyadmxqGTyM8fdIXlBnD+C
         KKmA==
X-Gm-Message-State: ANhLgQ0L0WMr2JdWGOVhnrGZt/wRC35Ldoa09bBljhThsZ7ULM5qj9Jc
        Xcm5xuw99OZd+aUfcyfiksnOtFM=
X-Google-Smtp-Source: ADFU+vuviF7mEkNoYzDfSJunh8TWE/dHRk3+NXogF7VS3jm3/A9hPAjGhxYqkL9Aiz3NL25XbxV//g==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr312144wmj.25.1583267804757;
        Tue, 03 Mar 2020 12:36:44 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id a9sm371472wmm.15.2020.03.03.12.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:36:44 -0800 (PST)
Date:   Tue, 3 Mar 2020 23:36:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/syscalls: deasmlinkage syscall table definition
Message-ID: <20200303203642.GA9737@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think that "sys_call_ptr_t" type being function pointer to asmlinkage
function is enough, array itself doesn't need to be asmlinkage.

It is not referenced by assembly code anymore anyway.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/entry/syscall_64.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -24,7 +24,7 @@ SYSCALL_DEFINE0(ni_syscall)
 #define __SYSCALL_64(nr, sym, qual) [nr] = sym,
 #define __SYSCALL_X32(nr, sym, qual)
 
-asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
+const sys_call_ptr_t sys_call_table[__NR_syscall_max + 1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
@@ -41,7 +41,7 @@ asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 #define __SYSCALL_64(nr, sym, qual)
 #define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
 
-asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max+1] = {
+const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max + 1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
