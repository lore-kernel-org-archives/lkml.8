Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4338C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C506F208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340642;
	bh=vTyuW465oi1ldPe5fL/nkyV1YZRgw8uEFV8K5VJecbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ham5DRIkCwI5ZxdgBrKHISw+0/yWcf3KKZexfTfr2fusMw9kD11WcTNexNCQ3t8hH
	 9VicYFfH3F2LkOms5DkMgfnYgBcVB80hPNMzXBWB3Pzp24YENyZv+nQdVOoiVBHXaE
	 1Gf4DDEqWcpaVYO8Y0xf/1aWuQCgpvAVKhsOyXF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgEANoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731439AbgEANn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:43:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6ACB208DB;
        Fri,  1 May 2020 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340637;
        bh=vTyuW465oi1ldPe5fL/nkyV1YZRgw8uEFV8K5VJecbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKUa1wzY2RXpoeKfJixlbBDsdDnPWgzjre+/AfTAXKLsgSUxZwQkiCAUVBAflSD5p
         d+hFrttjZ8IOdnsO5i+iqPcgDRSq5PFkoWMD69Wc/Iw6FtKUV62xeBmhab+riL0TSr
         Hj+bhRSfwi6LuBX0CYILh0UsWRhbgH+mMgwy7LVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang YanQing <udknight@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.6 063/106] bpf, x86_32: Fix logic error in BPF_LDX zero-extension
Date:   Fri,  1 May 2020 15:23:36 +0200
Message-Id: <20200501131551.363096069@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang YanQing <udknight@gmail.com>

commit 5ca1ca01fae1e90f8d010eb1d83374f28dc11ee6 upstream.

When verifier_zext is true, we don't need to emit code
for zero-extension.

Fixes: 836256bf5f37 ("x32: bpf: eliminate zero extension code-gen")
Signed-off-by: Wang YanQing <udknight@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200423050637.GA4029@udknight
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/net/bpf_jit_comp32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1847,7 +1847,7 @@ static int do_jit(struct bpf_prog *bpf_p
 			case BPF_B:
 			case BPF_H:
 			case BPF_W:
-				if (!bpf_prog->aux->verifier_zext)
+				if (bpf_prog->aux->verifier_zext)
 					break;
 				if (dstk) {
 					EMIT3(0xC7, add_1reg(0x40, IA32_EBP),


