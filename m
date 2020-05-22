Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C76C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C730204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="xq+rr9Nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgEVWnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbgEVWnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:43:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA984C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:43:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so2576097pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=EU5e/l95lnHmNp8beRxDwq3G8lD1LFgouw11x+VJMvM=;
        b=xq+rr9NhyM1ZgqTrmiGV4vdmnQTujwwHsg3dF5aeifUH4u6DfowA+gqRTLm3ocRwO/
         P8YHcMh6du4+wHtz4n29FBF6keDnjFVcZPaARuWX6nL7zBnRabH4zvU5RLH6SfRcPDCj
         fMfJYVKGZlN48oHAc2jIzqNO9hl8JGaDwwAzyv4HCNdGOdA6DS8dBVtuNzV+muc3Ju47
         ZjGm3agrWIA84ZCwDeCPXgdagTXGj83HpISN7Ihid+gFO5DN+Ppwkuh9jrsjKpFhxNWB
         y/tgKzs0K7KY9EanaMEFo9wtAWs9MAHPF3Hmf9H6u1RR97GZpDOSY+BWwWLzZb0SpIk3
         1FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EU5e/l95lnHmNp8beRxDwq3G8lD1LFgouw11x+VJMvM=;
        b=ZCVdWHBf8E1KeTgSZ6o8HMsfHEtjkvN1QiQBJHHo3WiDrDBCenq5js2cXnS0/q9idW
         hidd6HIVeE1KCqtfCqbBbQfVJcKTfjMi2+vLEGOlf7bd8YfqHKzX68GRT+AY1FPFCDXe
         iA9ZXX7+f7t19XQFa4AOBZl9QYZLymm8cobMzYXTdt5ppznsX6o3d7bpwEIQcN05oYWE
         Uuwop/Zl8YMe8QsE9LhU3FEU5LM7ZqH0vQx8okHVkDiPFaNv1x1NnNPYnJxfajPrzZ4e
         zhR+X/yTJIOrDyGrsAMhooRw499rv95CiaDV3smDI0hTGUJ2kVnBYu+/b/mPhKyMetU/
         dq0A==
X-Gm-Message-State: AOAM532W6niqLLq92fXw7E6WU/dvuOKWnXXNCnSu96hIbpISw/vO4oG6
        hAs8+wnY3So2r27kv3jauGjkhq/qkrI=
X-Google-Smtp-Source: ABdhPJyoTSra4X3zw/UGq89aJPKVz7w/MFz+PbHbZufPD5Y9Cc8R0iOnVNGiShdXCUom5TVcDY/vgQ==
X-Received: by 2002:a17:90b:3705:: with SMTP id mg5mr6651553pjb.24.1590187420961;
        Fri, 22 May 2020 15:43:40 -0700 (PDT)
Received: from ?IPv6:2600:1010:b008:3b8f:1dea:762f:4d89:de4d? ([2600:1010:b008:3b8f:1dea:762f:4d89:de4d])
        by smtp.gmail.com with ESMTPSA id s36sm6923408pgl.35.2020.05.22.15.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:43:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Date:   Fri, 22 May 2020 15:43:35 -0700
Message-Id: <692612FC-4599-4774-857C-7E20CD99A832@amacapital.net>
References: <20200522222055.GE25128@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
In-Reply-To: <20200522222055.GE25128@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 22, 2020, at 3:20 PM, Sean Christopherson <sean.j.christopherson@in=
tel.com> wrote:
>=20
> =EF=BB=BFOn Fri, May 22, 2020 at 03:13:57PM -0700, Andy Lutomirski wrote:
>>> On Fri, May 22, 2020 at 1:49 PM Peter Zijlstra <peterz@infradead.org> wr=
ote:
>>>=20
>>> Hai, this kills #DB during NMI/#MC and with that allows removing all the=
 nasty
>>> IST rewrite crud.
>>>=20
>>=20
>> This is great, except that the unconditional DR7 write is going to
>> seriously hurt perf performance.  Fortunately, no one cares about
>> perf, right? :)  Even just reading first won't help enough because DR7
>> reads are likely to be VM exits.  Can we have a percpu dr7 shadow
>> (with careful ordering) or even just a percpu count of dr7 users so we
>> can skip this if there are no breakpoints?
>=20
> Hmm, I believe hw_breakpoint_active() is what you're looking for, KVM uses=

> it to avoid unnecessary restoration of host DR7 after VM-Exit.
>=20
> Amusingly, checking that in the NMI handler could give a false positive if=

> an NMI occurs in guest as DR7 is cleared on exit and KVM invokes the NMI
> handler prior to restoring host DR7.  I doubt that's common enough to care=

> about though.

False positives are unavoidable: there=E2=80=99s no way we can set a percpu v=
ariable and set DR7 without risking an NMI in between.=
