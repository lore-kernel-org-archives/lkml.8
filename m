Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92999C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB5E206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDCr600x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD1Eff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:35:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27322 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgD1Eff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588048533;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7HOk8Yr6S3xlCmaSoOzLqX7HGoHGUwpA1okgxRGClTk=;
        b=QDCr600xggCL4FFJPRIkqSOjMKdK63z/UlAM6NFLRL8fb5kyNOn/dLthuMi3Ffa85oL8JT
        81vPL6aLht2+w4SAMepR5wqUEqxBGDFYWhmhAuqHeuSOgx2mq4j4VWeDXMfaPbxmp4T8D3
        n1Q4fGDWPK9MFqxw9tbYL/lIHgV8jIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-PmAvVPc_NI6x2PYmjDXjJA-1; Tue, 28 Apr 2020 00:35:27 -0400
X-MC-Unique: PmAvVPc_NI6x2PYmjDXjJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B1FD107ACCA;
        Tue, 28 Apr 2020 04:35:26 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81AE010013D9;
        Tue, 28 Apr 2020 04:35:23 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/mm: Reject invalid NUMA option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200424045314.16017-1-gshan@redhat.com>
 <20200424101132.GC1167@C02TD0UTHF1T.local>
 <f83c0ce1-b1b2-31f4-60c8-15567b87a8ff@redhat.com>
 <20200427225406.7cacc796@gandalf.local.home>
 <20200427225944.185d4431@gandalf.local.home>
 <20200427230920.3d606a2e@gandalf.local.home>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <7e85ea83-de5f-c789-2e3c-e468a50ed4bd@redhat.com>
Date:   Tue, 28 Apr 2020 14:35:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200427230920.3d606a2e@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven and Mark,

On 4/28/20 1:09 PM, Steven Rostedt wrote:

[...]

> 
> Could this be a bug in the implementation of strncmp() in
> arch/arm64/lib/strncmp.S. As I don't know arm64 assembly, I have no idea
> what it is trying to do.
> 
> But strncmp("o","off",3) returning zero *is* a bug.
> 

I think it's false alarm. The patch has been in my local repo for a while.
I checked out 5.7.rc3 and tried passing "numa=o" to the kernel, @numa_off
is unchanged and its value is false. I also check the return value from
strncmp() as below, it's correct. Nothing is broken. I should have retested
before posting it. Sorry for the noise. Please ignore the crap patch :)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4decf1659700..a8e5c6f7ba25 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -32,6 +32,13 @@ static __init int numa_parse_early_param(char *opt)
         if (str_has_prefix(opt, "off"))
                 numa_off = true;
  
+       pr_info("numa_off=%s\n", numa_off ? "true" : "false");
+       pr_info("opt=%s\n", opt);
+       pr_info("len=%d\n", (int)strlen("off"));
+       pr_info("\n");
+       pr_info("================================\n");
+       pr_info("strncmp(opt, 'off', 3)=%d\n", strncmp(opt, "off", 3));
+

[    0.000000] NUMA: numa_off=false
[    0.000000] NUMA: opt=o
[    0.000000] NUMA: len=3
[    0.000000] NUMA:
[    0.000000] NUMA: ================================
[    0.000000] NUMA: strncmp(opt, 'off', 3)=-102

Thanks,
Gavin



