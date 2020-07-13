Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E96DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627B2206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594610474;
	bh=3EMCx9Z+izfyqdgvZZu9CqNmFYJcUBErLYW7XKVOuUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=su8dRT9r1APnElUKf7Bwi+QC+6QM7rTNy8id30QuTExKF6BMieGiFkIWx757ClpWw
	 0QsXzjuljkPhVlU1+jC+0YFPvmF38O02Q4xckx4JgczDGMbVFsEG/eqzgEZ21eKjbS
	 gS8DuiULvK2iZVyL9E/LDneVao6kB2rq8ZTR+KXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGMDVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:21:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39815 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGMDVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:21:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id w3so11640408wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqBhf/wXork2iz5ZmVBFIfxYI4swpxPYsb+Goh/x6l0=;
        b=SzhzeiZ8LexEMPUmBrTiZkFpY9+vjTGGVO4WEzIS0BrNl2mUGpQTRyqaTzSyMXHnj5
         mLqCv95VTcHg7jMKqrkE5ms9K6sYbm7G12HjLkAn/6xCUlaZaR6PYhLUSveY5qUnFHzI
         vJTJyG1EX+I/psq0Jlky8avdG6XlTvECeW5+DB/39narMiH0BTpIfVOTTodeW1gIyKPf
         07x3zwAjPR6fcjV9KDuNb3w0muG9yRGLwQY8Rdh3x8vq8W+dMkyU0WaQgW8zbueq90jo
         xHNQHFKFzMaoewfj320OsPj2EYBTo7pbXOVEGv4jSF/x1eRY+F/Wi6M/cl9oMErG/1bu
         68Rg==
X-Gm-Message-State: AOAM531o2tmYaJy+h0E+E9NOlHYnKFzyP3r/bhUjzzR5MX6/m2Cjt43O
        hmmsjJoN49QTg3IH4lloNSR5dskov9s3+xt3wq4=
X-Google-Smtp-Source: ABdhPJy1FO+WUcH3wmEtuF/7FfmwEHqE6D+WLDjCoR/VGguOTadqb8eIZkWiMOIi8Z374q1gDfOD588OXr0CC1tVg+w=
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr17722620wmc.154.1594610470272;
 Sun, 12 Jul 2020 20:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com> <93e1c3b1-ee77-a94d-8806-049e0245fab7@linux.intel.com>
In-Reply-To: <93e1c3b1-ee77-a94d-8806-049e0245fab7@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Jul 2020 12:20:59 +0900
Message-ID: <CAM9d7cikDcaLaUv8+xh9fp_KVHFVQD+eRYGAR5kN4A7ppPHmBQ@mail.gmail.com>
Subject: Re: [PATCH v10 05/15] perf evlist: implement control command handling functions
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 4:50 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Implement functions of initialization, finalization and processing
> of control command messages coming from control file descriptors.
> Allocate control file descriptor as descriptor at struct pollfd
> object of evsel_list for atomic poll() operation.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
[SNIP]
> +static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
> +                             char *cmd_data, size_t data_size)
> +{
> +       int err;
> +       char c;
> +       size_t bytes_read = 0;
> +
> +       memset(cmd_data, 0, data_size--);

I overlooked the '--' at the end and thought there might be
buffer overflow..  Care to add a comment?

> +
> +       do {
> +               err = read(evlist->ctl_fd.fd, &c, 1);

Maybe I missed earlier discussion, but do we really want
this 1 byte read in a loop?

Thanks
Namhyung


> +               if (err > 0) {
> +                       if (c == '\n' || c == '\0')
> +                               break;
> +                       cmd_data[bytes_read++] = c;
> +                       if (bytes_read == data_size)
> +                               break;
> +               } else {
> +                       if (err == -1)
> +                               pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
> +                       break;
> +               }
> +       } while (1);
> +
> +       pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
> +                bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> +
> +       if (err > 0) {
> +               if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> +                            (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
> +                       *cmd = EVLIST_CTL_CMD_ENABLE;
> +               } else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> +                                   (sizeof(EVLIST_CTL_CMD_DISABLE_TAG)-1))) {
> +                       *cmd = EVLIST_CTL_CMD_DISABLE;
> +               }
> +       }
> +
> +       return err;
> +}
