Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1686DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF262074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZQuY4319"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCMVAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:00:48 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37734 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMVAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:00:48 -0400
Received: by mail-qv1-f68.google.com with SMTP id n1so1625452qvz.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/cckTxrWR8dAC8Hqil6zGHfyy5iVdJbz8EFbOeTTdIA=;
        b=ZQuY4319vZfZ9kOKsYrCZxcpWMkFubaKzUMdXbHa2rT//vs3IAtg1QpCZBIZ5GFZE7
         7EzrK4K/4vxPlZNKmaPjEKOR/t225dDuXvm+YybBshbmIOtwoZ569pPXQrDCIXXmXW/0
         IPhtxZ4PX4nHJCis8oa+z36FHVsNjU7RoCqSrsVFRNzzjZNPgFGqEORWIEpWJ4XMelB/
         6kQ3+8C0HWp1xqke2LOCUGr08SaL74A+398pQ9RckaQef4EfuDqRDn1ulzq1ETTi9YHU
         jjwDPo8dUJs+wB9hzKBNvRI9Aonbp7bqx9Lrbmb8NH3ScKY5ATzO7NY73owT8WH6aWYX
         irvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/cckTxrWR8dAC8Hqil6zGHfyy5iVdJbz8EFbOeTTdIA=;
        b=Eq2gx6hvPMeYDTDfWAzm5X77oOR+AtiFpnH5+BkFkmBfOm6Qbn+5L7Dl0/Fum7bc9w
         QnB+X7I4aeFr55YNzGRo5bC4DBAWP4TYErEv1dBOY9os5IC2HJrhnXZAgvB1bgSlUNQB
         PZwg8Xojk/dkfYwOPQ8jXPcsU4aWdKQb1NHqaQxamN/fWIxg853gn1gCSHci9WdDY8+i
         vLLDaBGRgJRK6VmFUCdA3QDXkkCBg7q8PthwplJpbQwa2EzBeQGcps7sphDCNwiKjt+f
         k9R3fOQiO3h8kRIotPupLw5PMVJ+qHrdefwF5YVEKFIdeLeORO24vgHm1FWY4M+wPcO0
         BFkQ==
X-Gm-Message-State: ANhLgQ1MLn1AD6nIUAldAC89dRsewU6T9qrNzmGyUSBZoZwxsZAwpd3C
        8TprA3z/72z6VkWmH/Fmc1kWtg==
X-Google-Smtp-Source: ADFU+vspAYkMqkpAkFiVGknIaFRalz4WbbMpy9twXUtevX1Pp6V2oAUwXO55GbW/bTusBn3uirwJYg==
X-Received: by 2002:ad4:5102:: with SMTP id g2mr8228177qvp.6.1584133245139;
        Fri, 13 Mar 2020 14:00:45 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w30sm6251299qtw.21.2020.03.13.14.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 14:00:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] timer: silenct a lockdep splat with debugobjects
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200313201314.GE5086@worktop.programming.kicks-ass.net>
Date:   Fri, 13 Mar 2020 17:00:41 -0400
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        rostedt@goodmis.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3115315-12A9-43A9-9209-09553CF2C71C@lca.pw>
References: <20200313154221.1566-1-cai@lca.pw>
 <20200313180811.GD12521@hirez.programming.kicks-ass.net>
 <4FFD109D-EAC1-486F-8548-AA1F5E024120@lca.pw>
 <20200313201314.GE5086@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 13, 2020, at 4:13 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Mar 13, 2020 at 03:32:52PM -0400, Qian Cai wrote:
>> Well, in mm/vmstat.c (init_mm_internals) case for example, it was =
initialized
>> as a static,
>>=20
>> static DECLARE_DEFERRABLE_WORK(shepherd, vmstat_shepherd);
>>=20
>> which will not call __debug_object_init().=20
>=20
> Then fix that.
>=20
> That is, all of:
>=20
>  DECLARE_DEFERRABLE_WORK
>  KTHREAD_DELAYED_WORK_INIT
>  DEFINE_TIMER
>=20
> are broken and need to go.

This looks invasive with so many callsites...

>=20
> Unless of course, you can frob debugobjects such that we can provide =
the
> required storage through is_static_object() and modify the above =
static
> declarators to provide the storage.

I=E2=80=99ll explore this which looks more promising.

>=20
> Or, fix that random crud to do the wakeup outside of the lock.

That is likely to be difficult until we can find a creative way to not =
=E2=80=9Cuglifying" the
random code by dropping locks in the middle etc just because of =
debugojects.

>=20
> Plenty options..

