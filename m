Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC60C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035BE20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e56uy6oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDYKYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:24:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47556 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726107AbgDYKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587810278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiiGjxMSfR/3HcuLZdv0rh/BGKXUkSP2JfWB96AlEV4=;
        b=e56uy6oq7GCXzI9LBQsCaTHhluggEXtKLCBU7J5jUlrLplKxrizVEi+oVcgk8jkyP8JaNa
        gWK3siU95OCKvmQpHV5YfpMntL3UKW6erTw/sARyXSGFpcyw2K/b6XgF74dL/EpA+Mn/pR
        QIBnNxIpsL3vFElAM6KQmb3gORwTnQo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-th1I6Ms9NpKo7D4EBP8E4Q-1; Sat, 25 Apr 2020 06:24:29 -0400
X-MC-Unique: th1I6Ms9NpKo7D4EBP8E4Q-1
Received: by mail-wr1-f72.google.com with SMTP id d17so6457282wrr.17
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 03:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AiiGjxMSfR/3HcuLZdv0rh/BGKXUkSP2JfWB96AlEV4=;
        b=n++8P0WDQNVMmjBWclSwkgyLPSRg3UO8NQxeEry7sUPwsNWSpz+qLtDg20Fk/N656W
         Tvn4ST1M0tT7DJaik/PPG4kV0NHdQT8wSlgLEkV2gTPNactPloZSxccJGVLGP8BpbmNH
         NmddZH1xKZ+mryWbd24Ky3z81ppeq+Y3tsxiymJ7sXoCeZ2FWBsYm/pGD6gHICBJ/Vit
         D+AMmrGYxVJyDIBAULzxcMRcnMHxcgHHAtKpaCciDzgFRZ9uNsViQDtphny9Irj5yGxu
         ZDIYDwgQa9hpYxTXKzZiIqlzctphuSZymUKz/8WNT20QYnkcch6kt1jBGEcJmx/Rqowk
         Z5Ow==
X-Gm-Message-State: AGi0PuZ/NwA0n5o+4KiDJ3giIcSzDMkR3yjNvL2IoJJO8XAcItAxNcCq
        9q7hcad2f13bRf4zzPUb6LnpTp3fRhy5CGO/hlBgaXLf2hgcZCKeWGqPr68AWSLwqPvj/A2BeDt
        9ZjhhPxx4beEDCRn0rS6k3T56
X-Received: by 2002:a5d:5745:: with SMTP id q5mr17541307wrw.351.1587810268503;
        Sat, 25 Apr 2020 03:24:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJCsnbfHqFriQbI24TXuIAXrqXN8iqz6uh+Ag2xVYIfCBS/H8oNA4RK58IzO9hfko5vLHJ96Q==
X-Received: by 2002:a5d:5745:: with SMTP id q5mr17541287wrw.351.1587810268284;
        Sat, 25 Apr 2020 03:24:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926? ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
        by smtp.gmail.com with ESMTPSA id t17sm11580360wro.2.2020.04.25.03.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 03:24:27 -0700 (PDT)
Subject: Re: [PATCH 5/5] kvm: Replace vcpu->swait with rcuwait
To:     Davidlohr Bueso <dave@stgolabs.net>, tglx@linutronix.de
Cc:     peterz@infradead.org, maz@kernel.org, bigeasy@linutronix.de,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        will@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20200424054837.5138-1-dave@stgolabs.net>
 <20200424054837.5138-6-dave@stgolabs.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69af54bb-8632-fbf7-d774-da9a954ff1b7@redhat.com>
Date:   Sat, 25 Apr 2020 12:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424054837.5138-6-dave@stgolabs.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm squashing this in to keep the changes compared to the current code minimal,
and queuing the series.

Thanks,

Paolo

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index bbefa2a7f950..feca3118b17f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -230,10 +230,10 @@ static bool kvmppc_ipi_thread(int cpu)
 static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 {
 	int cpu;
-	struct rcuwait *wait;
+	struct rcuwait *waitp;
 
-	wait = kvm_arch_vcpu_get_wait(vcpu);
-	if (rcuwait_wake_up(wait))
+	waitp = kvm_arch_vcpu_get_wait(vcpu);
+	if (rcuwait_wake_up(waitp))
 		++vcpu->stat.halt_wakeup;
 
 	cpu = READ_ONCE(vcpu->arch.thread_cpu);
@@ -3814,7 +3814,10 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 		}
 	}
 
+	prepare_to_rcuwait(&vc->wait);
+	set_current_state(TASK_INTERRUPTIBLE);
 	if (kvmppc_vcore_check_block(vc)) {
+		finish_rcuwait(&vc->wait);
 		do_sleep = 0;
 		/* If we polled, count this as a successful poll */
 		if (vc->halt_poll_ns)
@@ -3827,8 +3830,8 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	vc->vcore_state = VCORE_SLEEPING;
 	trace_kvmppc_vcore_blocked(vc, 0);
 	spin_unlock(&vc->lock);
-	rcuwait_wait_event(&vc->wait,
-			   kvmppc_vcore_check_block(vc), TASK_INTERRUPTIBLE);
+	schedule();
+	finish_rcuwait(&vc->wait);
 	spin_lock(&vc->lock);
 	vc->vcore_state = VCORE_INACTIVE;
 	trace_kvmppc_vcore_blocked(vc, 1);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7c2d18c12d87..c671de51a753 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2737,10 +2737,10 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_block);
 
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 {
-	struct rcuwait *wait;
+	struct rcuwait *waitp;
 
-	wait = kvm_arch_vcpu_get_wait(vcpu);
-	if (rcuwait_wake_up(wait)) {
+	waitp = kvm_arch_vcpu_get_wait(vcpu);
+	if (rcuwait_wake_up(waitp)) {
 		WRITE_ONCE(vcpu->ready, true);
 		++vcpu->stat.halt_wakeup;
 		return true;

