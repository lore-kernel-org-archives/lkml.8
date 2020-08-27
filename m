Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C48C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405DF20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBL1hdk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH0Dtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgH0Dtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:49:46 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B744BC0612A3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 20:49:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so4453936ioe.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fU7xS5CivaMNWa2AK46tOD8m+SFLPnhzRQv95SuRSUQ=;
        b=oBL1hdk0OtEtn93kqjZhKyLrBS5APXLWcyp2quP4Ige2GwfoNDrzfgjB2TiX/aHLL4
         qJGvpiidLIhR7mxZBUIBN30hWNZWyKxkdE/KpokKupgjNPS3GC3rvZ69JPQeuUl4jxTU
         HOHPC9T3xgFLJ5Z4ehiB15TE4PU3FDH7Cyv+7+0INCYypEhWtHND6Rkstz2zegrVGy+O
         WaeD5J+ynYbAEHFIs0VuLbgdCGBH0+6JHKBfNn4XLRgbEFXu6koYrAjASyI3IrgktVQj
         y4M7jqU4cay4GUoPBuxlGAbXdmcbfLvBu+Re8drgnrtKuIuFHTuYBFu8oSONZWxYCjYJ
         w/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fU7xS5CivaMNWa2AK46tOD8m+SFLPnhzRQv95SuRSUQ=;
        b=dR/M3uZDaGGZg1u914eEzB2sOhqwbPPduApNMicjwnB60eCibve249Rfl/4nMF2Ry/
         CXGZSpSok/aT0KzIZ8dT986Tj5HG71etwPz5Skeghs+g5HuEt02LfSlSa27eX94Dh7rY
         EQMWqgb8WIHK+tsL0DQIx7N2k72Ot/rB5CUgy6dOXvL7cZFGtM4E466LJzbiaCcDQ39R
         aDR18rtjFT8nzO+svlemWGtpgJURsi7ogm+2M3usTxlMTBMO7TnsXceTCkOzIj66Dqkx
         AC0MPx7pJ3au0SvQ+k13vulQFdRNbPSvK/6rE6fJnRf8uEc1F2qKTJKIkECsWUWZqvPq
         I1nQ==
X-Gm-Message-State: AOAM531R2zcD4NEISJrgkV4tQsgJ8BcWhIYGBzhiMXgUNYleWJkzgszk
        O/t+S/uvx57/dDOVCYVMdiDngihO1UfOPVU/e14=
X-Google-Smtp-Source: ABdhPJwPigRBo1K8q7pRYZ45A6GGNvQzIel93w70vcWbHHFDvDF/kzbXQ/pzVUqnyeEGIBvctlMzf4WNrl4KFQ37OWg=
X-Received: by 2002:a5d:980f:: with SMTP id a15mr15579146iol.12.1598500185034;
 Wed, 26 Aug 2020 20:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com>
 <20200820062533.GK18179@shao2-debian>
In-Reply-To: <20200820062533.GK18179@shao2-debian>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Thu, 27 Aug 2020 11:49:34 +0800
Message-ID: <CAPx_LQGBY-QzXnYMB4zZ=Q5yyRGFF9W68NgB8gqqXchRjUD2WQ@mail.gmail.com>
Subject: Re: [kthread] 2e7d8748eb: last_state.is_incomplete_run
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, axboe@kernel.dk,
        akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did not see any exceptions related to my changes,the corresponding
macro CONFIG_DEBUG_OBJECTS_KTHREAD is not enabled,so i think the issue
has nothing to do with my changes

Thanks

On Thu, 20 Aug 2020 at 14:26, kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 2e7d8748eba7e32150cbd4f57129ea77d1255892 ("[RFC V2] kthread: add object debug support")
> url: https://github.com/0day-ci/linux/commits/Qianli-Zhao/kthread-add-object-debug-support/20200812-131719
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git fb893de323e2d39f7a1f6df425703a2edbdf56ea
>
> in testcase: boot
>
> on test machine: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> kernel boot failed by kexec:
>
> user  :notice:  [32m[  +0.371313]  [0m [33mLKP [0m: kexec loading...
> user  :notice:  [32m[  +0.007118]  [0mkexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/2e7d8748eba7e32150cbd4f57129ea77d1255892/vmlinuz-5.8.0-12610-g2e7d8748eba7e --initrd=/opt/rootfs/tmp/initrd-concatenated
>
>
>
>
> Thanks,
> Rong Chen
>
