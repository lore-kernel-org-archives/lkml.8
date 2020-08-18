Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4727AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22982206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGZ7bHcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHROam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgHROaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:30:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC3CC061344;
        Tue, 18 Aug 2020 07:30:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h19so21660602ljg.13;
        Tue, 18 Aug 2020 07:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EKmO5OL8YqABBQxdTc7s+i0zzy1xBLouHzrebnJDpis=;
        b=mGZ7bHcElaXqrCYV9DL1BOj/IuS2bmiyPYX0PqgMOP9WF/77dT1kpyEyyglxYYmB4u
         EvEBaisupWAJrDa5DhO8+n5lvmQsxZyOM96nzQOaWEakY7evRmrpsxruxbpW1f39pmG8
         zYU9WXNjnNjfTv9uvN9T5/dd8ct/pKXRYCTyraUYNAh3C/M6HBtjo9i3gwo/ZnMcuQBK
         SmhkjHYQtoCe14V6Lakfz729CvVqy8p/SUWutYSruyat+fTgh3IAEsvGMNoqzn7Z5rBO
         F7SfX8bznQT5If88lPI5JXNGyrpa3w5rdZHQwgxzXdVgu8G4HdE250jxt9HK1GBfQo40
         FLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EKmO5OL8YqABBQxdTc7s+i0zzy1xBLouHzrebnJDpis=;
        b=U+8jeX+Z+GvykQohCp6ZuP8lQ5yIU81JmF9/cq602LjOi6gx9bbFlPqg1MmiNQuyfH
         4w41kUccHI6OupsfBLLYwgYMDXA/4pywW8j+gIQJHmAcC5Z4gPgyOVMD1p78r4I3K4xy
         28ac6sgfRRxN6vu4Uv9H6mkPjJhVSXXDhT7HZR3fKe01RuHwR7HM8yCKAqbZ3nUMqXPP
         aXZdKd24Hc0d4S4M2PfPlz0McO3XhkBhpUMUQ9wm1hDAvO0Zke51T7Q9RUjjjocMCQKy
         6gXAXE8uMLV1K8B/FWwiyqVHTvCjLTxuEXJpeJ1xFvfE6edon22U0/plg+XwtqxT2frI
         qhWQ==
X-Gm-Message-State: AOAM531x+O/Ja0DXbxghacO16a6ps/mq6VzasWmpbrkClrtXHFSajLoy
        O8tE6ZvxjZMXnrLVLn0sQTEwC9n4DnEBtpJ+pXSssGc4tu4=
X-Google-Smtp-Source: ABdhPJwDLwy9lrFbCZHRAPg/5oUtgAIZvmfT4IQOBkQIyITsssC28W0Q8MfrFwEwrIl2E+AXrkgrKVjw+etzb7teu24=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr6626678ljm.200.1597761023270;
 Tue, 18 Aug 2020 07:30:23 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 18 Aug 2020 20:00:11 +0530
Message-ID: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
Subject: Scheduler benchmarks
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I=E2=80=99ve two identical Linux systems with only kernel differences.
While doing kernel profiling with perf, I got the below mentioned
metrics for Scheduler benchmarks.

1st system (older kernel version compared to the other system) benchmark re=
sult:

$ perf bench sched messaging -g 64
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 64 groups =3D=3D 2560 processes run

     Total time: 2.936 [sec]


2nd system benchmark result:

$ perf bench sched messaging -g 64
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 64 groups =3D=3D 2560 processes run

     Total time: 10.074 [sec]


So as per scheduler benchmark results, clearly a huge difference
between two systems.
Can anyone suggest to me how to dive deeper to know the root cause for
it. Also are there any tunable kernel parameters related to this one?



--=20
Thanks,
Sekhar
