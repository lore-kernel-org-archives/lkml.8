Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE399C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8594C2137B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646516;
	bh=5lEnXrhdbHoYrpi5vExKkw+JGG6lV/ILVTNMrG4/8NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GlsBPeAnvcSzURW8pgUxUasMxPUWfUiFGmZF2io7epvwTdpfcGaN8edx4AYf8lE+n
	 nXQ6i8xtikTEZayQVVORIHykQYZdh+EltM+b8/R8rH7dU1hxBlDB6jh9YfmDzkcDGU
	 hdPxFL8/oiUlWS7yWuGWEkubQUSuQJGjad8WU/Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgCaJIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730570AbgCaJIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 139DE20787;
        Tue, 31 Mar 2020 09:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645719;
        bh=5lEnXrhdbHoYrpi5vExKkw+JGG6lV/ILVTNMrG4/8NI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCfPeCgNkk9iW0unTynbj6GLFXbTE0Qfe9vQbVkiwtN+y34LV2gs/wBy+iDUhxcwP
         BC7cpBRZAHYFQQ+WXWN1/UfpJn6G9FTTTW1NEMXbaVyXunMXPoAqsIv9qh2SAax+Ob
         G0rttMkxCbvwoxU6O1lI2LcIvi4I+VSGcZP7Rlcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshiki Komachi <komachi.yoshiki@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.5 142/170] bpf/btf: Fix BTF verification of enum members in struct/union
Date:   Tue, 31 Mar 2020 10:59:16 +0200
Message-Id: <20200331085438.478750978@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshiki Komachi <komachi.yoshiki@gmail.com>

commit da6c7faeb103c493e505e87643272f70be586635 upstream.

btf_enum_check_member() was currently sure to recognize the size of
"enum" type members in struct/union as the size of "int" even if
its size was packed.

This patch fixes BTF enum verification to use the correct size
of member in BPF programs.

Fixes: 179cde8cef7e ("bpf: btf: Check members of struct/union")
Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/1583825550-18606-2-git-send-email-komachi.yoshiki@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/btf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2383,7 +2383,7 @@ static int btf_enum_check_member(struct
 
 	struct_size = struct_type->size;
 	bytes_offset = BITS_ROUNDDOWN_BYTES(struct_bits_off);
-	if (struct_size - bytes_offset < sizeof(int)) {
+	if (struct_size - bytes_offset < member_type->size) {
 		btf_verifier_log_member(env, struct_type, member,
 					"Member exceeds struct_size");
 		return -EINVAL;


