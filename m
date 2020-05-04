Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B441C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3FF20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZlWc9CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgEDMns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727813AbgEDMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:43:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 05:43:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so15629614wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tGqBd41+9SAFTFtWd6QxQCXg4IBHseF/GjUWMiKLaNE=;
        b=NZlWc9CZ+r+xJEBKs98y07unWzzrWtzuDeAZ9z4hcrA0tKuF7Tv07Ojzi8MaPgOE29
         ievTUQVaP4A5QT6QYkhbMEmqX8u6mneOLXe5bDb6hRTeMtBOA84dNIxMnsOcJhPS9mFf
         /Kg97oIEBizSxex5cOTnq+9VlpyZvNJzZRQAiM4BG0pG/CrMywt72ftYrfvEcuQWkss5
         r3PAbOn/ahwPLKAiQUVu77wkJf1o50MFV+YdNzq5SAZMBETfOIjhsaaQNTbQWX2uRAbT
         hYuEljm5PvPtP8/eoPuYzf8smwQq3cA6yHFLiRCN4LYksbImiAbM/6L9JuYUSuxGiWjf
         Zg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tGqBd41+9SAFTFtWd6QxQCXg4IBHseF/GjUWMiKLaNE=;
        b=BcNGZbFY/zeVwOK49OvkNTZmeHZv76/0pLy2hbfeGIhKNBL4idrVFUKGmlN1hn+gyq
         ATqUldXORddam0TDfwETlhpg1aBR21U3hLUAdR7g1bE+L9Wn6GlKu9wK77UbG1AsdqcH
         aWSbG/sLv8MxKy0izq9t0/qtp8Ebn2H2UwzxymbuyDE1v05zgUd51bOUTT5AaeEmBf7r
         eNBEQ5XECiwq4kIyZd8a7QDfdGVWtgtrUuvynI1/hoBqwRc7TSxXeTLN/YCt9HE4fNpS
         pVlJYr9877rAIpSY89KU6YTQHbab7svo7GF9IuzW5jOhfkLbt8l/ku5T6FSE7h5bR2Z+
         qTng==
X-Gm-Message-State: AGi0PublAczigHx+PLpJ6+zTLsRPbQVL6HFF5WiLjQvS3P2VM8tdOQYT
        /OokATZ4rcYlWNEbvAAwSiE=
X-Google-Smtp-Source: APiQypL934W3Cb4rteay9yg4wuCdE/jpBr44JKGm8x9+kobLgNJz8BEV282yjranfmQ/qN45SSm+Fg==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr19440791wrp.275.1588596225845;
        Mon, 04 May 2020 05:43:45 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e102:ae00:682f:ab67:3325:b213? (2a02-8388-e102-ae00-682f-ab67-3325-b213.cable.dynamic.v6.surfer.at. [2a02:8388:e102:ae00:682f:ab67:3325:b213])
        by smtp.gmail.com with ESMTPSA id d9sm2835470wrg.60.2020.05.04.05.43.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 05:43:45 -0700 (PDT)
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, daniel.gruss@iaik.tugraz.at,
        michael.schwarz@iaik.tugraz.at, martin.schwarzl@iaik.tugraz.at,
        moritz.lipp@iaik.tugraz.at
From:   Andreas Kogler <andreas.kogler.0x@gmail.com>
Subject: [PATCH] Perf: do not overwrite precise Intel-PEBS timestamp
Message-ID: <e754b625-bf14-8f5f-bd1a-71d774057005@gmail.com>
Date:   Mon, 4 May 2020 14:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation:
We wanted to reconstruct the precise order of perf event samples as they were written into the PEBS buffer.
Therefore we configured multiple perf sampling events that conform to the restrictions for using PEBS on Intel CPUs.
Since perf event samples get written to the mmap buffer in blocks of the same event type, we also configured the
events to include the timestamp via PERF_SAMPLE_TIME flag, so we can later reorder the samples by the time they appeared.

After reordering by the timestamp, we observed that the samples are still ordered in blocks even though they appeared
interleaved in the PEBS buffer.

The precise timing of the event samples is lost and overwritten with the timestamp while the sample is
written to the output buffer. If more then one perf sampling event is configured, it is not possible to reconstruct the
original order of the interleaved event occurrences.

We provide a test program, Makefile, and sample output to demonstrate the differences of the output with and without the patch.
The test program records 'near call' and 'near return' events. The PEBS timestamps are supported since the Skylake generation.

Cause:
The precise PEBS timestamp is overwritten while storing the 'perf_sample_data' struct into the output buffer.
The timestamp is correctly read into the 'perf_sample_data' struct from the PEBS buffer and then passed on to the
output function. The output function then fills in the remaining fields of the 'perf_sample_data' struct and accidentally
overwrites the precise timestamp.

The callstack from reading the timestamp from PEBS until it gets overwritten:

    /arch/x86/events/intel/ds.c:1753 __intel_pmu_pebs_event                  -> /arch/x86/events/intel/ds.c:1340 setup_pebs_fixed_sample_data
        /arch/x86/events/intel/ds.c:1476 setup_pebs_fixed_sample_data        : 'perf_sample_data' time stamp gets set from PEBS buffer
    /arch/x86/events/intel/ds.c:1754 __intel_pmu_pebs_event                  -> /kernel/events/core.c:7183 perf_event_output
        /kernel/events/core.c:7187 perf_event_output                         -> /kernel/events/core.c:7137 __perf_event_output
            /kernel/events/core.c:7151 __perf_event_output                   -> /kernel/events/core.c:6971 perf_prepare_sample
                /kernel/events/core.c:6984 perf_prepare_sample               -> /kernel/events/core.c:6565 __perf_event_header__init_id
                    /kernel/events/core.c:6581 __perf_event_header__init_id  : 'perf_sample_data' time stamp gets overwritten


Patch:
We provide a patch for a minimalistic solution and an idea for a more complex patch.

The minimal patch proposal would be to zero out the time field of the 'perf_sample_data' struct in the 'perf_sample_data_init' function
and check if the field is still zero in the '__perf_event_header__init_id' function. This patch includes magic numbers and might not be
extendable but is very minimalistic and performant. See 'pebs_time_fix.patch'.

The other idea would be to reorder the function calls to call '__perf_event_header__init_id' before filling the 'perf_sample_data' struct
with the PEBS buffer data fields in '__intel_pmu_pebs_event' and therefore split up the 'perf_event_output' function into two parts.
This solution will introduce no performance overhead but will have a high impact on existing code and will possible duplicate some code parts,
from the 'perf_event_output' function.

Kind regards,
Andreas Kogler (+ the CoreSec team from Graz University of Technology) 

Developer's Certificate of Origin 1.1

Signed-off-by: Andreas Kogler <andreas.kogler.0x@gmail.com>


File begin: pebs_time_fix.patch ##############################################################################
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 87e21681759c..fd3963e2ac6e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1041,6 +1041,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->weight = 0;
 	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
+	data->time = 0;
 }
 
 extern void perf_output_sample(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a9a7e20b734a..1e0a7ba8c744 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6577,7 +6577,7 @@ static void __perf_event_header__init_id(struct perf_event_header *header,
 		data->tid_entry.tid = perf_event_tid(event, current);
 	}
 
-	if (sample_type & PERF_SAMPLE_TIME)
+	if ((sample_type & PERF_SAMPLE_TIME) && (data->time == 0))
 		data->time = perf_event_clock(event);
 
 	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER))

File end: pebs_time_fix.patch -----------------------------------------------------------------------------


File begin: Makefile ##############################################################################
all:
	gcc order_test.c -o order_test

run:
	./order_test | sort

init:
	echo -1 | sudo tee /proc/sys/kernel/perf_event_paranoid
	sudo sysctl -w kernel.perf_cpu_time_max_percent=0

clean:
	-rm order_test

File end: Makefile -----------------------------------------------------------------------------


File begin: order_test.c ##############################################################################
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdio.h>

#include <unistd.h>

#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>

#include <linux/perf_event.h>

#define BUFFER_SIZE (4096 * (16 + 1))

struct __attribute__((packed)) sample {
    struct perf_event_header header;
    uint64_t ip;
    uint64_t time;
    uint64_t id;
};

static long perf_event_open(struct perf_event_attr *hw_event, int pid, int cpu, int group_fd, unsigned long flags) {
    return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
}

static void __attribute__((noinline)) call_dup() {
}

static void __attribute__((noinline)) test_function() {
    // the hardware only provides each 2nd call and ret event so we
    // make a 2nd call and ret here
    call_dup();
}

int main() {
    struct perf_event_attr attr;
    memset(&attr, 0, sizeof(struct perf_event_attr));
    attr.size                     = sizeof(struct perf_event_attr);
    attr.exclude_kernel           = 1;
    attr.exclude_hv               = 1;
    attr.exclude_callchain_kernel = 1;
    attr.exclude_callchain_user   = 1;
    attr.exclude_guest            = 1;
    attr.exclude_idle             = 1;

    attr.disabled                 = 1;
    attr.freq                     = 0;

    attr.sample_period            = 1;
    attr.precise_ip               = 3;
    attr.watermark                = 0;
    attr.wakeup_events            = 0;
    
    attr.read_format              = 0;
    attr.sample_id_all            = 0;
    attr.clockid                  = 0; // so the pebs timestamp is used if available
    attr.aux_watermark            = 0;
    
    attr.type                     = PERF_TYPE_RAW;
    attr.sample_type              = PERF_SAMPLE_IP | PERF_SAMPLE_ID | PERF_SAMPLE_TIME;

    
    // BR_INST_RETIRED.NEAR_CALL
    attr.config                   = 0x02C4; 
    attr.pinned                   = 1;
    attr.exclusive                = 1;

    int group_fd = perf_event_open(&attr, 0, -1, -1, 0);
    if (group_fd < 0) {
        printf("error opening group fd, forgot 'make init'? errno: %d\n", group_fd);
        return -1;
    }
     
    // BR_INST_RETIRED.NEAR_RETURN
    attr.config                   = 0x08C4;
    attr.pinned                   = 0; //only group leader is pinnend
    attr.exclusive                = 0; //only group leader is exclusive

    int child_fd = perf_event_open(&attr, 0, -1, group_fd, 0);
    if (child_fd < 0) {
        printf("error opening child fd, forgot 'make init'? errno: %d\n", child_fd);
        close(group_fd);
        return -1;
    }

    uint64_t near_call_id, near_return_id;
    ioctl(group_fd, PERF_EVENT_IOC_ID, &near_call_id);
    ioctl(child_fd, PERF_EVENT_IOC_ID, &near_return_id);
    
    struct perf_event_mmap_page* buffer =
        mmap(NULL, BUFFER_SIZE, PROT_READ, MAP_SHARED, group_fd, 0);

    if (buffer == (void*)-1) {
        puts("error allocating buffer!");
        close(group_fd);
        close(child_fd);
        return -1;
    }

    // remap output of 2nd event to the buffer of the group leader
    // this want influence the timestamp behaviour
    ioctl(child_fd, PERF_EVENT_IOC_SET_OUTPUT, group_fd);

    // start recording
    ioctl(group_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);

    // generate near call and near return events
    for (int i =0; i < 10; ++i) {
        test_function();
    }

    // stop recording
    ioctl(group_fd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
    // refresh (not needed)
    ioctl(group_fd, PERF_EVENT_IOC_REFRESH, PERF_IOC_FLAG_GROUP);

    // walk the recorded samples
    char* begin = (char*)buffer + buffer->data_offset + buffer->data_tail % buffer->data_size;
    char* end   = (char*)buffer + buffer->data_offset + buffer->data_head % buffer->data_size;

    char* current = begin;

    while (current != end) {
        struct sample *s = (struct sample *)current;

        if (s->header.type == PERF_RECORD_SAMPLE) {
            // print timestamp and type so we can later sort the events with 'sort'
            if (s->id == near_call_id) {
                printf("%lu CALL\n", s->time);
            } else if (s->id == near_return_id) {
                printf("%lu RET\n", s->time);
            }
        }
        current += s->header.size;
    }

    close(group_fd);
    close(child_fd);
    munmap(buffer, BUFFER_SIZE);
}
File end: order_test.c -----------------------------------------------------------------------------


File begin: unpatched.out ##############################################################################
4137004686155 CALL
4137004686761 CALL
4137004686948 CALL
4137004687131 CALL
4137004687318 CALL
4137004687504 CALL
4137004687690 CALL
4137004687871 CALL
4137004688053 CALL
4137004688298 CALL
4137004688616 RET
4137004688806 RET
4137004688989 RET
4137004689166 RET
4137004689344 RET
4137004689522 RET
4137004689704 RET
4137004689884 RET
4137004690065 RET
4137004690274 RET
File end: unpatched.out -----------------------------------------------------------------------------


File begin: patched.out ##############################################################################
91672433854 CALL
91672434605 RET
91672435330 CALL
91672436082 RET
91672436806 CALL
91672437551 RET
91672438274 CALL
91672439023 RET
91672439751 CALL
91672440492 RET
91672441216 CALL
91672441959 RET
91672442689 CALL
91672443434 RET
91672444150 CALL
91672444894 RET
91672445615 CALL
91672446365 RET
91672447114 CALL
File end: patched.out -----------------------------------------------------------------------------

