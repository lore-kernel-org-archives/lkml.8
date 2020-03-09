Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE861C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86971208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDUWyFjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCIPwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:52:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727224AbgCIPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583769157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpdJ6Cg1tIsPQIU8l639Qlh3t2/IFpSBkTvWUWG8TI0=;
        b=dDUWyFjq4MA3tZETP9GPTkN7Oi3RXHahq/Ccz1Y4rc9ushbBA3KAo/SV9/dGGRZ83oe4D3
        XZtRVKRf0PUYUMPsf4rzIOS4CB/aTHEh7sU/zelIpSHG/IkJQ3dfb1Aebzrvz4n4/2w3aW
        raDa21RqJut1sEQDXYsfLTk2cO06950=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-U5FZplORPxWqBrA9hfwPFg-1; Mon, 09 Mar 2020 11:52:35 -0400
X-MC-Unique: U5FZplORPxWqBrA9hfwPFg-1
Received: by mail-wr1-f70.google.com with SMTP id c6so5365135wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpdJ6Cg1tIsPQIU8l639Qlh3t2/IFpSBkTvWUWG8TI0=;
        b=AzLsCWKYIqOmUENlGIKF+R6C+8zBkchkQ/ug3AzK9BaDur2ViCRpQlSUOqgAyefx7i
         C5E1DvBqvVhKhDIC5xvnEc5yz8ioqA9Dff/xhGgIK2MyFKrxYj6p23eI5VhSxDArC7dr
         giohMRGsq7lEPVHyxlBuyTrS7h08xzWC8KUsJAiQjeXYlP7R0I4A3U50/IWaRKLd5EEz
         Ldd+O0SYAYZamz9Hjjr96+Z5TXWiBjj7awUN49DwjZBfceZSy1A0gf57ImPW2BBQKgxx
         vacMBW2SavMvpsxPsTDwX3gg8IYs2nZtlCTfVWA5OKSSwwZEmoTcJn0pRyvwYtqykpg5
         HwBQ==
X-Gm-Message-State: ANhLgQ0h5/xSKTEU1aY6WmmLC1LSKNdB2ei798krsE1mQYoJDacExwmZ
        cYUkuV8UaMoL8kEiGLDy/BaT+B66CUHs31R1BjmtgPfep/uEzzV7Qej9BpQrCocnaauW2yZDBTC
        jAG7CF2npMq2CcBSBfBwhSGNd
X-Received: by 2002:a1c:9d41:: with SMTP id g62mr19391301wme.131.1583769154409;
        Mon, 09 Mar 2020 08:52:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vucLw7YOCnn8HRRRJAIb3+rjAedSA1dvQR96Or6tajfe9jl5CymLzC/u8rLXBoNjwCxXzD9vw==
X-Received: by 2002:a1c:9d41:: with SMTP id g62mr19391282wme.131.1583769154229;
        Mon, 09 Mar 2020 08:52:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q4sm17294521wro.56.2020.03.09.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:52:32 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH 6/6] KVM: selftests: enlightened VMPTRLD with an incorrect GPA
Date:   Mon,  9 Mar 2020 16:52:16 +0100
Message-Id: <20200309155216.204752-7-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309155216.204752-1-vkuznets@redhat.com>
References: <20200309155216.204752-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that guest doesn't hang when an invalid eVMCS GPA is specified.
Testing that #UD is injected would probably be better but selftests lack
the infrastructure currently.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/x86_64/evmcs_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 10e9c158dc96..fed8f933748b 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -72,6 +72,10 @@ void guest_code(struct vmx_pages *vmx_pages)
 		l1_guest_code(vmx_pages);
 
 	GUEST_DONE();
+
+	/* Try enlightened vmptrld with an incorrect GPA */
+	evmcs_vmptrld(0xdeadbeef, vmx_pages->enlightened_vmcs);
+	GUEST_ASSERT(vmlaunch());
 }
 
 int main(int argc, char *argv[])
@@ -120,7 +124,7 @@ int main(int argc, char *argv[])
 		case UCALL_SYNC:
 			break;
 		case UCALL_DONE:
-			goto done;
+			goto part1_done;
 		default:
 			TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
 		}
@@ -152,6 +156,10 @@ int main(int argc, char *argv[])
 			    (ulong) regs2.rdi, (ulong) regs2.rsi);
 	}
 
-done:
+part1_done:
+	_vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
+		    "Unexpected successful VMEnter with invalid eVMCS pointer!");
+
 	kvm_vm_free(vm);
 }
-- 
2.24.1

