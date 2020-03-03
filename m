Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C5C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4062064A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgCCObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbgCCObH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:31:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717AC20714;
        Tue,  3 Mar 2020 14:31:05 +0000 (UTC)
Date:   Tue, 3 Mar 2020 09:31:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zzyiwei@google.com, mingo@redhat.com, elder@kernel.org,
        federico.vaga@cern.ch, tony.luck@intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com,
        bhelgaas@google.com, darekm@google.com, ndesaulniers@google.com,
        joelaf@google.com, linux-kernel@vger.kernel.org,
        prahladk@google.com, android-kernel@google.com
Subject: Re: [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
Message-ID: <20200303093104.260b1946@gandalf.local.home>
In-Reply-To: <20200303141505.GA3405@kroah.com>
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
        <20200302235044.59163-1-zzyiwei@google.com>
        <20200303090703.32b2ad68@gandalf.local.home>
        <20200303141505.GA3405@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 15:15:05 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Mar 03, 2020 at 09:07:03AM -0500, Steven Rostedt wrote:
> > 
> > Greg,
> > 
> > You acked this patch before, did you want to ack it again, and I'll take it
> > in my tree?  
> 
> Sure, but where did my ack go?  What changed from previous versions???
> 
> Anyway, the patch seems sane enough to me:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Your previous ack was was here:

  https://lore.kernel.org/lkml/20200213004029.GA2500609@kroah.com/

And the patch changed since then (although, only cosmetically), so your ack
was removed. The diff between this patch and the patch you acked is this:

-- Steve

diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
index 3b632a2b5100..1897822a9150 100644
--- a/include/trace/events/gpu_mem.h
+++ b/include/trace/events/gpu_mem.h
@@ -28,34 +28,27 @@
  *
  */
 TRACE_EVENT(gpu_mem_total,
-	TP_PROTO(
-		uint32_t gpu_id,
-		uint32_t pid,
-		uint64_t size
-	),
-	TP_ARGS(
-		gpu_id,
-		pid,
-		size
-	),
+
+	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
+
+	TP_ARGS(gpu_id, pid, size),
+
 	TP_STRUCT__entry(
 		__field(uint32_t, gpu_id)
 		__field(uint32_t, pid)
 		__field(uint64_t, size)
 	),
+
 	TP_fast_assign(
 		__entry->gpu_id = gpu_id;
 		__entry->pid = pid;
 		__entry->size = size;
 	),
-	TP_printk(
-		"gpu_id=%u "
-		"pid=%u "
-		"size=%llu",
+
+	TP_printk("gpu_id=%u pid=%u size=%llu",
 		__entry->gpu_id,
 		__entry->pid,
-		__entry->size
-	)
+		__entry->size)
 );
 
 #endif /* _TRACE_GPU_MEM_H */
