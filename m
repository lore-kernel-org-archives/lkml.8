Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE9C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB64520757
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586623158;
	bh=ut2xbjRs0UxaeyGa71mvzMJ4GWyyeMJ6jwnYaHuRQcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nMLiBYtT9+95tlyOLf9melMsAyEjqo1xtiWCuVRXeDrwABlYSMpUVnMyrpzEiduqG
	 NR+t1jjSiw3mm568M7DuF+MB5DdGSfY9y6+GdlO2Y0iyZ+CdGbxZUQ+VqQ/m2w/he9
	 CDMWnx5Q6bTk4ZNPV9FZwEores86Ke9YWpGZOlQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDKQi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 12:38:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43494 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgDKQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:38:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id h25so4775669lja.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHjNiAPiJ1Oz2tFcDWgKOCe+L+oTgqAXQPJRZQ/4hzk=;
        b=fURPhmhZDafu3/qkIgLMIEfe4A4py1LqcCqCeBR+aVwJ7drlaVanUhZYjyx5KCUiZx
         KGDD6HlS++yVH8L88Y7vc/HiMTfe8JLWu5zgSXu8r7QLGa8LZ7tfbZa2cOHm/M603dUP
         wu/c+M9wGg8Em1o8TiiYeR2NppvuUZeOBDKjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHjNiAPiJ1Oz2tFcDWgKOCe+L+oTgqAXQPJRZQ/4hzk=;
        b=K4VAo7EXVOBW8e9Mvw11xganXe8SzcmHp2wi1CcuFsavf1wo5LhMloa7ERkxNe63h4
         4oYirma3DoQTWWWPpaxGU4iYxYgdPRET/AeImA+CLaP68MCJ5sQTcJp7SzsDkljzZdwp
         We6c4rdyVHxIE4ABLkRuJZ7Zjii6sbydrpjHjIi7PwssYnjAYvt74Rvn56G5ZdbEPlwG
         Ygnbu2j7T8S7/oGRA3pgWvuM/RmC8dWu6vcQc2M0AL/j9LKG424q1EvnmMc02PEUqPKO
         l5kw1aHo+feStjTPXhFH2orTQupnalafEURlbYS+yr2EHp0X/hh//eLMbT/Vzgtd/k9M
         3Wsg==
X-Gm-Message-State: AGi0Puav7g/zZnZ4Cjr6RS3v2Y9wbe2V6m6rs6+7/AVXS9FQUvO4vcFj
        sUcM5wNDDlsjUfi1cPwmAcXN7jHcoWg=
X-Google-Smtp-Source: APiQypL9Vuw965azEuZjRW/p70wsgwiazczG97R5I3Y5zRXGKh+giIrFh7YdJkACVJZaAQdXFaLsXw==
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr5977666ljk.23.1586623103405;
        Sat, 11 Apr 2020 09:38:23 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w10sm3656188ljh.85.2020.04.11.09.38.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 09:38:22 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n17so4780822lji.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 09:38:21 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr6327984ljj.265.1586623101184;
 Sat, 11 Apr 2020 09:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200406171124-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200406171124-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 09:38:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7sMywb2V8gifhpUDE=DWQTvg1wDieKVc0UoOSsOrynw@mail.gmail.com>
Message-ID: <CAHk-=wg7sMywb2V8gifhpUDE=DWQTvg1wDieKVc0UoOSsOrynw@mail.gmail.com>
Subject: Re: [GIT PULL] vhost: fixes, vdpa
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, eperezma@redhat.com,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>,
        lingshan.zhu@intel.com, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Rientjes <rientjes@google.com>, tiwei.bie@intel.com,
        tysand@google.com,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <wei.w.wang@intel.com>,
        xiao.w.wang@intel.com, yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 2:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The new vdpa subsystem with two first drivers.

So this one is really annoying to configure.

First it asks for vDPA driver for virtio devices (VIRTIO_VDPA) support.

If you say 'n', it then asks *again* for VDPA drivers (VDPA_MENU).

And then when you say 'n' to *that* it asks you for Vhost driver for
vDPA-based backend (VHOST_VDPA).

This kind of crazy needs to stop.

Doing kernel configuration is not supposed to be like some truly
horrendously boring Colossal Cave Adventure game where you have to
search for a way out of maze of twisty little passages, all alike.

                Linus
