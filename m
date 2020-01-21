Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7EFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D26124125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FSED5JXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgAUPvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:51:01 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:37446 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgAUPvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:51:01 -0500
Received: by mail-qt1-f174.google.com with SMTP id w47so2984755qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=TSx1IacjA36C7gRcUNqAiUk52Ru2xAt6jsIMGDeM5kc=;
        b=FSED5JXeH7JMEFRDifhZbjZ4BjsiEodHmzWcTAdNLBgEJ0gWI+N0lPPP1IPNqXHf4S
         zDWOcuNV/9WBBka7TdArzN2hfkxuq2A4VqDhgo2uEG77umIYL1kmlo/JLHcrz8Thdeeq
         xd56xjAmYkHad1d7vpAPWP25Fi7hLSgpsWpPl7G8sXOK7Xy/Vki3ZAf/EqjTXwT98ESU
         8HVY0YhlpVn88LP8e+mx6vwCyKkJJMF/IYczprzhSKDCKUjDwQbki+cfTqOUlCEU4xG3
         GubVElkTj5l0Caa6j/0wWqWd5UBqQ+BT29Z/oEiQIetZXlCMqhnIOTQbx+I86bY//l1C
         Dt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=TSx1IacjA36C7gRcUNqAiUk52Ru2xAt6jsIMGDeM5kc=;
        b=RJv/G6T+YI6xIOZxv+mEJiIseEA6ipxUjZHPbBy+nWCDKaMGgi4VVM9ve3bgP95fvz
         xf94UpZhCU1d5SJ0UCyniyzh2BoUoxPhH4Fg58hQzCnlkOH+ry0ME+KtqjVK3yC4J+CK
         QUFvSeVpgMhOa4434ByLCTOLHHzRI2yZK2cqTx4h9fMZdrCj/RsIekcQhA3/L0dDkHnM
         VWyryvFdrm8806J43+Nbh6QWyuCN9sxsh86gZA8ZUXecwEtDUPzNOFZ7hq6+6L7f/RBO
         YUrNwsmVS1NQHrQxTT/Xyod59m7DgLs+af7PcxnsxHKq6AKPSooVzzefRM3goA6fwJU0
         rmpQ==
X-Gm-Message-State: APjAAAWkSoNft6KqL9orGf7/hzsIljEmC2tN9XgD05fqWwxg1aMGUdMz
        GEUmhd6BnYUeD7nCIwmft7r/RF3B+BUdjA==
X-Google-Smtp-Source: APXvYqwaCrYcu9GXaMWjCpD9zq1ed1F/qgV/p031Oq8MDLRDLZBsg6KywZCQBNkdHctFIqUqr+XJtA==
X-Received: by 2002:ac8:7356:: with SMTP id q22mr5067604qtp.162.1579621858159;
        Tue, 21 Jan 2020 07:50:58 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t3sm19740433qtc.8.2020.01.21.07.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 07:50:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Date:   Tue, 21 Jan 2020 10:50:56 -0500
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Message-Id: <388BB7AF-C7AB-4F0D-B79A-A43097C12E62@lca.pw>
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2020, at 10:45 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> Perhaps because you've been dealing with KCSAN for so long. :-)
>=20
> The main angle here, IMO, is that this "fix" is being done solely for
> KCSAN. Or is there another reason to "fix" intentional data races? At
> least I don't see one. And the text says
>=20
> "This will generate a lot of noise on a debug kernel with
> debug_pagealloc with KCSAN enabled which could render the system
> unusable."
>=20
> So yes, I think it should say something about making KCSAN happy.
>=20
> Oh, and while at it I'd prefer it if it did the __no_kcsan function
> annotation instead of the data_race() thing.

Or the patch title could be =E2=80=9Cplay KCSAN well with debug_pagealloc=E2=
=80=9D?

I am fine with __no_kcsan as well. I just need to retest the whole thing fir=
st.=
