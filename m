Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113D7C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB0120774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylaNAWxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgHNO1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgHNO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 10:27:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93112C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 07:27:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so10850720iow.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQhwH7MFqLmI8YjCU5gOMtThxJSGR8nuWwc+QkdqkrQ=;
        b=ylaNAWxMMiOZBRtVdDDLvc3fZQdX71lhMBLz8zZIbntlqVeUIFSERmkwuQh9dFjKF0
         pcEXBn4Qz4N/PXKAXMGbyA2e+i+JNdf2nLcegayJOmzNe252AfdH9Yb9d8hssWP7O6ew
         eI6Np5GsBBk3SeBCV0t2vyr4CB0ksyhd9yY7QveyckDt2C34Xz19ngkjAkV/YkD33FDW
         ExrCXcf1qBPTnMa/dlSinOA6fTJC1XGSoXUf476tUAkaizZElBt6feNhELB8M+6Fdzun
         koEzraVZcZ7UbD00r/HJBP7TCn2XLe18dImgdrD81Lmru7kpxd6q0LE1QAV1UbNbBZva
         WuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQhwH7MFqLmI8YjCU5gOMtThxJSGR8nuWwc+QkdqkrQ=;
        b=tR9iRup/alH7MTEzoQc7COD9mkpba9OuxUhRFLxTgqbfunsAowKoU9F06RrQpGG9vW
         E7ii+exgHZhrINNwyj3c8yyEF8O+ZU4UOHTH7xm4H5ihpazdV4WcyxMp7NWJMwqmGfEU
         FBb1/c1Jcv8sruUwXE4SjbKNbIJwVUyQlmlgVzZVWiQ38s/gtNgqbG4QAyga3KC0LYGo
         /9X4S3yFWo/090U5sDeQio2p+v4e4Vky1UAEWw/9NIbxZyZcIWtHnRmwvEYr8Y9huZts
         jISCJP6xI13Xz7GR1J2ErrjgMLbezAvQXT3lc7tSKrTzNbjTlisqB4oJ51Tgizd2iael
         /1hw==
X-Gm-Message-State: AOAM530mamb8vYzqiKG0NluhmUtQPQJcXeCtINnYQVOxEIeAkUcjqTK4
        /0+B/yUCnIlS05zirwvkVg850je0Fgc5aLBLLlpv0NG9YR4IET7Q
X-Google-Smtp-Source: ABdhPJxfVWKgAkHvD+ZnFZB4/BrNkEkCSaGv8tgICSNyYEuGjPse5IgsWT/R0Aw/PWCH8CktsU1Zguch8BBRpz9Ll8M=
X-Received: by 2002:a02:9047:: with SMTP id y7mr3025875jaf.128.1597415259662;
 Fri, 14 Aug 2020 07:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvVEhs_HROaXaW70mWrp_z6N4mJ-3rfFs0iAcT9Kg3A1A@mail.gmail.com>
 <20200814084123.5b64c0cf@oasis.local.home>
In-Reply-To: <20200814084123.5b64c0cf@oasis.local.home>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Aug 2020 19:57:27 +0530
Message-ID: <CA+G9fYv0mhj1VVb99mS1akTaQxZD9TBcrFVoU9pdctMhG1r8BQ@mail.gmail.com>
Subject: Re: WARNING: at kernel/trace/trace.c:1727 update_max_tr_single.part.0+0xa8/0x148
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sean Paul <sean@poorly.run>, lkft-triage@lists.linaro.org,
        Ingo Molnar <mingo@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 at 18:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 14 Aug 2020 14:53:36 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> > steps to reproduce:
> > # Boot qemu arm64 with trace configs enabled ^.
> > # cd /opt/ltp
> > # ./runltp -f tracing
>
> I don't run ltp, what  exactly is this doing?

LTP running ftrace stress testing

Test case :
------------
LOOP=200

# Use up to 10% of free memory
free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
cpus=`tst_ncpus`

step=$(( $free_mem / 10 / $LOOP / $cpus ))

if [ $step -eq 0 ]; then
    step=1
    LOOP=50
fi

while true; do
    new_size=1
    i=0
    while [ $i -lt $LOOP ]; do
        echo $new_size > "$TRACING_PATH"/buffer_size_kb  ----> Test
got failed here
        new_size=$(( $new_size + $step ))
        i=$((i + 1))
    done

    i=0
    while [ $i -lt $LOOP ]; do
        new_size=$(( $new_size - $step ))
        echo $new_size > "$TRACING_PATH"/buffer_size_kb
        i=$((i + 1))
    done
    sleep 1
done


test case link,
https://raw.githubusercontent.com/linux-test-project/ltp/master/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh

ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
[   90.729590] ------------[ cut here ]------------
[   90.729882] WARNING: CPU: 1 PID: 2840 at
kernel/trace/ring_buffer.c:1273 rb_set_head_page+0x7c/0x108
[   90.733593] Modules linked in: rfkill snd_soc_hdmi_codec
crct10dif_ce adv7511 cec qcom_spmi_temp_alarm rtc_pm8xxx msm
snd_soc_msm8916_analog qcom_camss mdt_loader videobuf2_dma_sg
v4l2_fwnode videobuf2_memops snd_soc_lpass_apq8016 i2c_qcom_cci
drm_kms_helper snd_soc_lpass_cpu qcom_rng snd_soc_msm8916_digital
videobuf2_v4l2 snd_soc_lpass_platform snd_soc_apq8016_sbc
snd_soc_qcom_common videobuf2_common qrtr ns socinfo display_connector
drm rmtfs_mem fuse
[   90.761426] CPU: 1 PID: 2840 Comm: cat Not tainted 5.8.0-next-20200814 #1
[   90.782653] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   90.789423] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=--)
[   90.796165] pc : rb_set_head_page+0x7c/0x108
[   90.801416] lr : rb_per_cpu_empty+0x18/0x88
[   90.805922] sp : ffff80001673bc30

File and line number:
kernel/trace/ring_buffer.c:1273 rb_set_head_page

static struct buffer_page *
rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
{
    struct buffer_page *head;
    struct buffer_page *page;
    struct list_head *list;
    int i;

    if (RB_WARN_ON(cpu_buffer, !cpu_buffer->head_page))
        return NULL;

    /* sanity check */
    list = cpu_buffer->pages;
    if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev->next) != list))
        return NULL;

    page = head = cpu_buffer->head_page;
    /*
     * It is possible that the writer moves the header behind
     * where we started, and we miss in one loop.
     * A second loop should grab the header, but we'll do
     * three loops just because I'm paranoid.
     */
    for (i = 0; i < 3; i++) {
        do {
            if (rb_is_head_page(cpu_buffer, page, page->list.prev)) {
                cpu_buffer->head_page = page;
                return page;
            }
            rb_inc_page(cpu_buffer, &page);
        } while (page != head);
    }

    RB_WARN_ON(cpu_buffer, 1);  ---> pointing this link number 1273

Full test case output and kernel warning,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200814/testrun/3066187/suite/linux-log-parser/test/check-kernel-bug-1668287/log

- Naresh Kamboju

>
> -- Steve
