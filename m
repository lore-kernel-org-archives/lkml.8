Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B976C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F412067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtUKo8iK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGOV4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOV4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:56:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4AAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:56:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p205so3891400iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=As7QIJiovyT5tTHmkDyx1rtxmK/oi3tEGiCkioLWPCg=;
        b=wtUKo8iK3pUwGQDovLaIvT98QQhpOheln2lAa6A4mX1V1Y1E8IBdHAqSDiaHFUvkDR
         hc3Gb6+lC725T9yVYF+8BsgLkoykYqlf8lCNXZPeWYtPzotR8PtYAgiEUzzZu7ry5qyJ
         WDBJ3o12me6PhceEb0CUlHSFVQfsdcOglyFpg6ag/2oaDESqqC5TF00Yp8l/ZMwGf75B
         HNhGoQ6d1XGuxA7QjC3o4KoudZpsmcCs+oOjRSOF7JgrsITvvqyXYLN7sB9FxIbnP19A
         9fOahHw1Wv+lj+Cr9nfa018ajO+SvZdsio2iyM4ivTedTqTIRwW8mKcrXD4lwE8MOHrb
         3umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=As7QIJiovyT5tTHmkDyx1rtxmK/oi3tEGiCkioLWPCg=;
        b=FzaeogD8d7Y0gkN95xR0oqDcCrp3OAf+hQkiWN0EfrAGluO4Ihr4VuKw4wzHWJZr1c
         ePYzyX7pCFEdZETphX4PEjm2Cec/UyYzIJiXsE2QZOdLY8pkqWeFubmjrSQJtSB571Yx
         u3ZHqaHG+O7BgcmVuasPxawXrPWD4JmlanruVsqlZCgrK4ppy4ggGoH8Zo3mvn4vS7ix
         wQLHhC+yPWAR0qSAd3nei4BUwOgtLslPuxVs4xMhyvBH8ZZo6V5l90t7UM4fbN2pcsrQ
         yImqU0ScvgOk8X0BpolGjsaXmMUZHfxM6USG7JRygNyDeLP7bAisoLzHxW8WbYRrrrez
         pztw==
X-Gm-Message-State: AOAM532gIjX7wcqyrtGdmt1SxJa+ttSnO2puFOHYBz7UahflPokfCMhI
        G+T3NDgqtOk1kmMrmdpQnGSBrsyBx7XFbn0AIUFMRA==
X-Google-Smtp-Source: ABdhPJyyYj1989VvKFQm2IxcppmyLEEDNrePXN8Fudog5bxvugiYllkt+2xD8FXr6dIzkRtzIbmYCsgQjQSBk/6qtqA=
X-Received: by 2002:a02:7f89:: with SMTP id r131mr1586001jac.98.1594850166605;
 Wed, 15 Jul 2020 14:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <1594326716-15474-1-git-send-email-rishabhb@codeaurora.org>
 <1594326716-15474-4-git-send-email-rishabhb@codeaurora.org>
 <20200714175332.GB1407705@xps15> <ab1003538546fddbdf2ee5f80e76b614@codeaurora.org>
In-Reply-To: <ab1003538546fddbdf2ee5f80e76b614@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 15 Jul 2020 15:55:55 -0600
Message-ID: <CANLsYkx-jYjX2C_xLSeSvk2_2dyrmHOiGpOHp9RUBbc9zkVZpA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] remoteproc: Add inline coredump functionality
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        tsoni <tsoni@codeaurora.org>, psodagud <psodagud@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 at 13:22, <rishabhb@codeaurora.org> wrote:
>
> On 2020-07-14 10:53, Mathieu Poirier wrote:
> > On Thu, Jul 09, 2020 at 01:31:55PM -0700, Rishabh Bhatnagar wrote:
> >> The current coredump implementation uses vmalloc area to copy
> >> all the segments. But this might put strain on low memory targets
> >> as the firmware size sometimes is in tens of MBs. The situation
> >> becomes worse if there are multiple remote processors undergoing
> >> recovery at the same time. This patch adds inline coredump
> >> functionality that avoids extra memory usage. This requires
> >> recovery to be halted until data is read by userspace and free
> >> function is called. Also modify the qcom_q6v5_mss driver to include
> >> size and offset in the segment dump function.
> >>
> >> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> >> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> >> ---
> >>  drivers/remoteproc/qcom_q6v5_mss.c       |  11 ++-
> >>  drivers/remoteproc/remoteproc_coredump.c | 160
> >> +++++++++++++++++++++++++++----
> >>  include/linux/remoteproc.h               |  21 +++-
> >>  3 files changed, 166 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c
> >> b/drivers/remoteproc/qcom_q6v5_mss.c
> >> index c6ce032..79df354 100644
> >> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> >> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> >> @@ -1199,11 +1199,12 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >>
> >>  static void qcom_q6v5_dump_segment(struct rproc *rproc,
> >>                                 struct rproc_dump_segment *segment,
> >> -                               void *dest)
> >> +                               void *dest, size_t cp_offset, size_t size)
> >
> > Now that I'm taking another look at this, refactoring
> > qcom_q6v5_dump_segment()
> > should be in another patch - please split them.
> >
> Hi Mathieu,
> Thanks for reviewing.
>
> Since I'm changing the API signature if we just take this patch without
> q6v5_mss
> changes (in a separate patch) it would cause compilation errors. Is that
> ok?

Just fix the arguments in q6v5_mss to match the signature and then do
another patch to implement the inline coredump feature.

> >>  {
> >>      int ret = 0;
> >>      struct q6v5 *qproc = rproc->priv;
> >>      int offset = segment->da - qproc->mpss_reloc;
> >> +    size_t cp_size = size ? size : segment->size;
> >
> > I can't find a scenario where size is 0 - can you explain when
> > such condition occurs?
> >
> There is no such case right now. I can get rid of the check.
> > Thanks,
> > Mathieu
> >
> >
> >>      void *ptr = NULL;
> >>
> >>      /* Unlock mba before copying segments */
> >> @@ -1219,16 +1220,16 @@ static void qcom_q6v5_dump_segment(struct
> >> rproc *rproc,
> >>      }
> >>
> >>      if (!ret)
> >> -            ptr = ioremap_wc(qproc->mpss_phys + offset, segment->size);
> >> +            ptr = ioremap_wc(qproc->mpss_phys + offset + cp_offset, cp_size);
> >>
> >>      if (ptr) {
> >> -            memcpy(dest, ptr, segment->size);
> >> +            memcpy(dest, ptr, cp_size);
> >>              iounmap(ptr);
> >>      } else {
> >> -            memset(dest, 0xff, segment->size);
> >> +            memset(dest, 0xff, cp_size);
> >>      }
> >>
> >> -    qproc->current_dump_size += segment->size;
> >> +    qproc->current_dump_size += cp_size;
> >>
> >>      /* Reclaim mba after copying segments */
> >>      if (qproc->current_dump_size == qproc->total_dump_size) {
> >> diff --git a/drivers/remoteproc/remoteproc_coredump.c
> >> b/drivers/remoteproc/remoteproc_coredump.c
> >> index ded0244..646886f 100644
> >> --- a/drivers/remoteproc/remoteproc_coredump.c
> >> +++ b/drivers/remoteproc/remoteproc_coredump.c
> >> @@ -5,6 +5,7 @@
> >>   * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> >>   */
> >>
> >> +#include <linux/completion.h>
> >>  #include <linux/devcoredump.h>
> >>  #include <linux/device.h>
> >>  #include <linux/kernel.h>
> >> @@ -12,6 +13,12 @@
> >>  #include "remoteproc_internal.h"
> >>  #include "remoteproc_elf_helpers.h"
> >>
> >> +struct rproc_coredump_state {
> >> +    struct rproc *rproc;
> >> +    void *header;
> >> +    struct completion dump_done;
> >> +};
> >> +
> >>  /**
> >>   * rproc_coredump_cleanup() - clean up dump_segments list
> >>   * @rproc: the remote processor handle
> >> @@ -72,7 +79,8 @@ int rproc_coredump_add_custom_segment(struct rproc
> >> *rproc,
> >>                                    dma_addr_t da, size_t size,
> >>                                    void (*dumpfn)(struct rproc *rproc,
> >>                                                   struct rproc_dump_segment *segment,
> >> -                                                 void *dest),
> >> +                                                 void *dest, size_t offset,
> >> +                                                 size_t size),
> >>                                    void *priv)
> >>  {
> >>      struct rproc_dump_segment *segment;
> >> @@ -114,12 +122,110 @@ int rproc_coredump_set_elf_info(struct rproc
> >> *rproc, u8 class, u16 machine)
> >>  }
> >>  EXPORT_SYMBOL(rproc_coredump_set_elf_info);
> >>
> >> +static void rproc_coredump_free(void *data)
> >> +{
> >> +    struct rproc_coredump_state *dump_state = data;
> >> +
> >> +    complete(&dump_state->dump_done);
> >> +    vfree(dump_state->header);
> >> +}
> >> +
> >> +static void *rproc_coredump_find_segment(loff_t user_offset,
> >> +                                     struct list_head *segments,
> >> +                                     size_t *data_left)
> >> +{
> >> +    struct rproc_dump_segment *segment;
> >> +
> >> +    list_for_each_entry(segment, segments, node) {
> >> +            if (user_offset < segment->size) {
> >> +                    *data_left = segment->size - user_offset;
> >> +                    return segment;
> >> +            }
> >> +            user_offset -= segment->size;
> >> +    }
> >> +
> >> +    *data_left = 0;
> >> +    return NULL;
> >> +}
> >> +
> >> +static void rproc_copy_segment(struct rproc *rproc, void *dest,
> >> +                           struct rproc_dump_segment *segment,
> >> +                           size_t offset, size_t size)
> >> +{
> >> +    void *ptr;
> >> +
> >> +    if (segment->dump) {
> >> +            segment->dump(rproc, segment, dest, offset, size);
> >> +    } else {
> >> +            ptr = rproc_da_to_va(rproc, segment->da + offset, size);
> >> +            if (!ptr) {
> >> +                    dev_err(&rproc->dev,
> >> +                            "invalid copy request for segment %pad with offset %zu and size
> >> %zu)\n",
> >> +                            &segment->da, offset, size);
> >> +                    memset(dest, 0xff, size);
> >> +            } else {
> >> +                    memcpy(dest, ptr, size);
> >> +            }
> >> +    }
> >> +}
> >> +
> >> +static ssize_t rproc_coredump_read(char *buffer, loff_t offset,
> >> size_t count,
> >> +                               void *data, size_t header_sz)
> >> +{
> >> +    size_t seg_data, bytes_left = count;
> >> +    ssize_t copy_sz;
> >> +    struct rproc_dump_segment *seg;
> >> +    struct rproc_coredump_state *dump_state = data;
> >> +    struct rproc *rproc = dump_state->rproc;
> >> +    void *elfcore = dump_state->header;
> >> +
> >> +    /* Copy the vmalloc'ed header first. */
> >> +    if (offset < header_sz) {
> >> +            copy_sz = memory_read_from_buffer(buffer, count, &offset,
> >> +                                              elfcore, header_sz);
> >> +
> >> +            return copy_sz;
> >> +    }
> >> +
> >> +    /*
> >> +     * Find out the segment memory chunk to be copied based on offset.
> >> +     * Keep copying data until count bytes are read.
> >> +     */
> >> +    while (bytes_left) {
> >> +            seg = rproc_coredump_find_segment(offset - header_sz,
> >> +                                              &rproc->dump_segments,
> >> +                                              &seg_data);
> >> +            /* EOF check */
> >> +            if (!seg) {
> >> +                    dev_info(&rproc->dev, "Ramdump done, %lld bytes read",
> >> +                             offset);
> >> +                    break;
> >> +            }
> >> +
> >> +            copy_sz = min_t(size_t, bytes_left, seg_data);
> >> +
> >> +            rproc_copy_segment(rproc, buffer, seg, seg->size - seg_data,
> >> +                               copy_sz);
> >> +
> >> +            offset += copy_sz;
> >> +            buffer += copy_sz;
> >> +            bytes_left -= copy_sz;
> >> +    }
> >> +
> >> +    return count - bytes_left;
> >> +}
> >> +
> >>  /**
> >>   * rproc_coredump() - perform coredump
> >>   * @rproc:  rproc handle
> >>   *
> >>   * This function will generate an ELF header for the registered
> >> segments
> >> - * and create a devcoredump device associated with rproc.
> >> + * and create a devcoredump device associated with rproc. Based on
> >> the
> >> + * coredump configuration this function will directly copy the
> >> segments
> >> + * from device memory to userspace or copy segments from device
> >> memory to
> >> + * a separate buffer, which can then be read by userspace.
> >> + * The first approach avoids using extra vmalloc memory. But it will
> >> stall
> >> + * recovery flow until dump is read by userspace.
> >>   */
> >>  void rproc_coredump(struct rproc *rproc)
> >>  {
> >> @@ -129,11 +235,13 @@ void rproc_coredump(struct rproc *rproc)
> >>      size_t data_size;
> >>      size_t offset;
> >>      void *data;
> >> -    void *ptr;
> >>      u8 class = rproc->elf_class;
> >>      int phnum = 0;
> >> +    struct rproc_coredump_state dump_state;
> >> +    enum rproc_dump_mechanism dump_conf = rproc->dump_conf;
> >>
> >> -    if (list_empty(&rproc->dump_segments))
> >> +    if (list_empty(&rproc->dump_segments) ||
> >> +        dump_conf == RPROC_COREDUMP_DISABLED)
> >>              return;
> >>
> >>      if (class == ELFCLASSNONE) {
> >> @@ -143,7 +251,14 @@ void rproc_coredump(struct rproc *rproc)
> >>
> >>      data_size = elf_size_of_hdr(class);
> >>      list_for_each_entry(segment, &rproc->dump_segments, node) {
> >> -            data_size += elf_size_of_phdr(class) + segment->size;
> >> +            /*
> >> +             * For default configuration buffer includes headers & segments.
> >> +             * For inline dump buffer just includes headers as segments are
> >> +             * directly read from device memory.
> >> +             */
> >> +            data_size += elf_size_of_phdr(class);
> >> +            if (dump_conf == RPROC_COREDUMP_DEFAULT)
> >> +                    data_size += segment->size;
> >>
> >>              phnum++;
> >>      }
> >> @@ -182,23 +297,30 @@ void rproc_coredump(struct rproc *rproc)
> >>              elf_phdr_set_p_flags(class, phdr, PF_R | PF_W | PF_X);
> >>              elf_phdr_set_p_align(class, phdr, 0);
> >>
> >> -            if (segment->dump) {
> >> -                    segment->dump(rproc, segment, data + offset);
> >> -            } else {
> >> -                    ptr = rproc_da_to_va(rproc, segment->da, segment->size);
> >> -                    if (!ptr) {
> >> -                            dev_err(&rproc->dev,
> >> -                                    "invalid coredump segment (%pad, %zu)\n",
> >> -                                    &segment->da, segment->size);
> >> -                            memset(data + offset, 0xff, segment->size);
> >> -                    } else {
> >> -                            memcpy(data + offset, ptr, segment->size);
> >> -                    }
> >> -            }
> >> +            if (dump_conf == RPROC_COREDUMP_DEFAULT)
> >> +                    rproc_copy_segment(rproc, data + offset, segment, 0,
> >> +                                       segment->size);
> >>
> >>              offset += elf_phdr_get_p_filesz(class, phdr);
> >>              phdr += elf_size_of_phdr(class);
> >>      }
> >>
> >> -    dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> >> +    if (dump_conf == RPROC_COREDUMP_DEFAULT) {
> >> +            dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> >> +            return;
> >> +    }
> >> +
> >> +    /* Initialize the dump state struct to be used by
> >> rproc_coredump_read */
> >> +    dump_state.rproc = rproc;
> >> +    dump_state.header = data;
> >> +    init_completion(&dump_state.dump_done);
> >> +
> >> +    dev_coredumpm(&rproc->dev, NULL, &dump_state, data_size, GFP_KERNEL,
> >> +                  rproc_coredump_read, rproc_coredump_free);
> >> +
> >> +    /*
> >> +     * Wait until the dump is read and free is called. Data is freed
> >> +     * by devcoredump framework automatically after 5 minutes.
> >> +     */
> >> +    wait_for_completion(&dump_state.dump_done);
> >>  }
> >> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> >> index e7b7bab..38d037d 100644
> >> --- a/include/linux/remoteproc.h
> >> +++ b/include/linux/remoteproc.h
> >> @@ -435,6 +435,20 @@ enum rproc_crash_type {
> >>  };
> >>
> >>  /**
> >> + * enum rproc_dump_mechanism - Coredump options for core
> >> + * @RPROC_COREDUMP_DEFAULT: Copy dump to separate buffer and carry on
> >> with
> >> +                            recovery
> >> + * @RPROC_COREDUMP_INLINE:  Read segments directly from device memory.
> >> Stall
> >> +                            recovery until all segments are read
> >> + * @RPROC_COREDUMP_DISABLED:        Don't perform any dump
> >> + */
> >> +enum rproc_dump_mechanism {
> >> +    RPROC_COREDUMP_DEFAULT,
> >> +    RPROC_COREDUMP_INLINE,
> >> +    RPROC_COREDUMP_DISABLED,
> >> +};
> >> +
> >> +/**
> >>   * struct rproc_dump_segment - segment info from ELF header
> >>   * @node:   list node related to the rproc segment list
> >>   * @da:             device address of the segment
> >> @@ -451,7 +465,7 @@ struct rproc_dump_segment {
> >>
> >>      void *priv;
> >>      void (*dump)(struct rproc *rproc, struct rproc_dump_segment
> >> *segment,
> >> -                 void *dest);
> >> +                 void *dest, size_t offset, size_t size);
> >>      loff_t offset;
> >>  };
> >>
> >> @@ -466,6 +480,7 @@ struct rproc_dump_segment {
> >>   * @dev: virtual device for refcounting and common remoteproc
> >> behavior
> >>   * @power: refcount of users who need this rproc powered up
> >>   * @state: state of the device
> >> + * @dump_conf: Currently selected coredump configuration
> >>   * @lock: lock which protects concurrent manipulations of the rproc
> >>   * @dbg_dir: debugfs directory of this rproc device
> >>   * @traces: list of trace buffers
> >> @@ -499,6 +514,7 @@ struct rproc {
> >>      struct device dev;
> >>      atomic_t power;
> >>      unsigned int state;
> >> +    enum rproc_dump_mechanism dump_conf;
> >>      struct mutex lock;
> >>      struct dentry *dbg_dir;
> >>      struct list_head traces;
> >> @@ -630,7 +646,8 @@ int rproc_coredump_add_custom_segment(struct rproc
> >> *rproc,
> >>                                    dma_addr_t da, size_t size,
> >>                                    void (*dumpfn)(struct rproc *rproc,
> >>                                                   struct rproc_dump_segment *segment,
> >> -                                                 void *dest),
> >> +                                                 void *dest, size_t offset,
> >> +                                                 size_t size),
> >>                                    void *priv);
> >>  int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16
> >> machine);
> >>
> >> --
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> >> Forum,
> >> a Linux Foundation Collaborative Project
> >>
