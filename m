Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C97C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A194120663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDu+M4Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgGGVzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgGGVzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:55:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CF1C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:55:12 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s21so22203804ilk.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XyLSVKIR+JMIR7yFvb6fbFjTd+vg1WmvQ48yrDadmU=;
        b=QDu+M4HkWoR5rSRnVxYjzQkL9q96XgE08yqX5qL1nWJaJApbd6eaKqfIiHiIxFxoVb
         kjJzMfFKt3E5B7zfB7RDkCN3LmmwvSK8y7i9XG+fX33/0q6YSpQGlvdZ5Yd8YHKat1LP
         c9lDZxe/wzxhRb+K334jfwrmu7amFqQWgiZ0dLPKOKr3jTRoQ5eEfpulWbwdkPuJwc4i
         8UmpjKR5ESzwgj7+KTfGRljsGGQ+Nj+juqe4wFsOeMCZJA5M3sCLT45So02t58a5zyZc
         +V6y8ESesAKe2zOCI6QsqYgVVtXArPzTVeJv4XWKyyHEcR1XOG8RQ+6GffJzE6ff3d/u
         1CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XyLSVKIR+JMIR7yFvb6fbFjTd+vg1WmvQ48yrDadmU=;
        b=Nqk1KivZC0Rtfoc+7CXb12+1+kEZAqEcEcRXrPI0efs7ZfVP8ZhgVfpK1iSKx7FZBi
         VOqCC8cExynywv0iQH5fZrmYlQoUIV9Ay8NzAgKIOc93Nnlnn61LdKrWT4WS8w+rJe+U
         O0qQtZ0lRQNMhBIYZJpQMEDb+WJXCENT3cTEL7jgZjkqQOT6r6ixpJXa94dmCRJHi4ys
         w9k7txSthDLadDm1E626mpK0/W1MmxELXWqJu9wPCfNv9KJ9Ya1Aw1kqELtnYBafPBaT
         ZcBj4GsuCHljBV/Cp5P0QDG5dD8C7B/P9X1jNJQgx3fEpFvIwEH6ialjRwZBmRHCnbP6
         a0nw==
X-Gm-Message-State: AOAM530o1LYIoY1I0NE8ZeRIgh8/LKbsyrA1cI1yWORef4j+kTc/ASJ5
        UU1j+vhSOxcGyBgHFpg0CQDWT6+Bzc1/Ti640iH4mw==
X-Google-Smtp-Source: ABdhPJwo8f/Fuce+0By/7zirMGcK9x+KJjQsfmSLx6FAb9Po6F9cjp5HrEniWOYNcIob/Vz6wCEBoyD+mRNZ+Rgdg40=
X-Received: by 2002:a92:a197:: with SMTP id b23mr36779115ill.58.1594158911835;
 Tue, 07 Jul 2020 14:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <1593460933-4262-1-git-send-email-rishabhb@codeaurora.org>
 <1593460933-4262-3-git-send-email-rishabhb@codeaurora.org>
 <20200706174717.GA614737@xps15> <d76c781be0551e140d041ebfd73a55f3@codeaurora.org>
In-Reply-To: <d76c781be0551e140d041ebfd73a55f3@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 7 Jul 2020 15:55:00 -0600
Message-ID: <CANLsYkw+KbfoktXbGVNk1icMoJao_=HsxXKS4sKDwEqU9wmRyg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] remoteproc: Add inline coredump functionality
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

On Tue, 7 Jul 2020 at 11:12, <rishabhb@codeaurora.org> wrote:
>
> On 2020-07-06 10:47, Mathieu Poirier wrote:
> > On Mon, Jun 29, 2020 at 01:02:12PM -0700, Rishabh Bhatnagar wrote:
> >> The current coredump implementation uses vmalloc area to copy
> >> all the segments. But this might put strain on low memory targets
> >> as the firmware size sometimes is in tens of MBs. The situation
> >> becomes worse if there are multiple remote processors undergoing
> >> recovery at the same time. This patch adds inline coredump
> >> functionality that avoids extra memory usage. This requires
> >> recovery to be halted until data is read by userspace and free
> >> function is called.
> >>
> >> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> >> ---
> >>  drivers/remoteproc/qcom_q6v5_mss.c       |   9 +-
> >>  drivers/remoteproc/remoteproc_coredump.c | 160
> >> +++++++++++++++++++++++++++----
> >>  include/linux/remoteproc.h               |  21 +++-
> >>  3 files changed, 165 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c
> >> b/drivers/remoteproc/qcom_q6v5_mss.c
> >> index 903b2bb..d4ff9b8 100644
> >> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> >> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> >> @@ -1200,12 +1200,13 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >>
> >>  static void qcom_q6v5_dump_segment(struct rproc *rproc,
> >>                                 struct rproc_dump_segment *segment,
> >> -                               void *dest)
> >> +                               void *dest, size_t cp_offset, size_t size)
> >>  {
> >>      int ret = 0;
> >>      struct q6v5 *qproc = rproc->priv;
> >>      unsigned long mask = BIT((unsigned long)segment->priv);
> >>      int offset = segment->da - qproc->mpss_reloc;
> >> +    size_t cp_size = size ? size : segment->size;
> >>      void *ptr = NULL;
> >
> > On the V4 of this set the above line was:
> >
> > +       void *ptr = rproc_da_to_va(rproc, segment->da + offset,
> > copy_size);
> >
> > Back then both Bjorn and I had RB'ed this set and all that was required
> > was a
> > rebase to linux-next.  On V5 and V6 our RBs have been removed, the
> > above has
> > been changed and an iounmap() was been added below.  Yet nothing in the
> > cover
> > letter provides an explanation that justifies the modification.
> >
> > What is going on here?
> >
> Hi Mathieu,
> The qcom_q6v5_dump_segment code has changed in the latest tip. That's
> why I had to
> make modifications to my patch. Sibi reviewed this patch as he made the
> above
> changes to mss driver and he has reviewed and tested from his side. He
> has
> also created a minor fix in the driver to make inline dumps work for
> mss.
> https://patchwork.kernel.org/patch/11637159/
>
> I removed the reviewed-by because I made some modifications to this
> patch
> and was not sure if the reviewed-by still applied. Let me know if i
> should add it
> again.

Removing the reviewed-by was the right thing to do but not mentioning
that something had changed in the cover letter was perplexing.  I had
to fish out previous revisions and compare each line to figure out
what has happened, an exercise that was time consuming.

I will take another look at your patchset but it may not be until next week.

Thanks,
Mathieu

> >>
> >>      /* Unlock mba before copying segments */
> >> @@ -1221,13 +1222,13 @@ static void qcom_q6v5_dump_segment(struct
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
> >>      qproc->dump_segment_mask |= mask;
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
> >> index e7b7bab..43e45a3 100644
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
> >> + * @dump_conf: Currenlty selected coredump configuration
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
