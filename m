Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A51C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCACB21556
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1JTMEkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCAEQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 23:16:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37378 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgCAEQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:16:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id q23so8006257ljm.4;
        Sat, 29 Feb 2020 20:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aUNhSk4XiLO4JVswFHsb4th4Idff4PdkPgnCTD0hgkI=;
        b=I1JTMEkxzMBH3C/Ciby3PlqiyiMfD/nJ/o2wOAOjQvw2YH9yrAJ58t0Sapyndq6MYx
         Qi0CD5xSzKT4bfeJZOLQqUkdWCJFDpLm6ZXdRGbwdSdJkWWsTIymgvYul03/pqr6GWYh
         chzhBcioJY7OX1mg6jQd49fDNYa4VElpccDAV//P0NsoeF0jdioT6K8nHPMb0bq//jtb
         wyUUU2txXE3y8W+Y9jI1HuGTgaWpjnNsuSl1KFHa1PRqzeqocnWSYa+gKIMkKh16m4ua
         KQJxWxT2D1FsaccJV/gBTDLu+Rhi4+vkaSnc4u3vkPYB5Grz/tqwmoAZAEr4wF86eYeh
         hg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aUNhSk4XiLO4JVswFHsb4th4Idff4PdkPgnCTD0hgkI=;
        b=enxqx2n1izV1LgdU/H3kuJKm2RAxkUY2F6jcEGbaE5rdL2idnCqzviTwNBk0YDCnr3
         g3KsaEts0mlBm3wVfXda+ch4bH9odiwlpkXFweFEVJBv9cEUt02s0lGzY8zzIrQMjyQT
         XYP3L9bHINSIEiVvpCj0BA0PJraxqklQUcil3p+TItPwKub8uRfIJFfBQAbHSCYYV/Mw
         GGG1/TGE6eHZb1bHMEgQYNjv4BcNrWns8pobPQRmbdUmzdqG/gMRuPn6g4NzDLjlSnLZ
         ImKVYn30mI0J2j3NO4SHSfMD4BlJWAPUSzOp02vpKh6ZeSElc2q3qvNmxXlduhrC0OKn
         Jm/A==
X-Gm-Message-State: ANhLgQ3UcIkT+5ptKYwTlThzxkZc1BpP41+OHr0A9x7YMEQsd9HeSM43
        FZltmU5+KxQLnKoC8AwopD8=
X-Google-Smtp-Source: ADFU+vuuiIbd/U+4zor59WByPUmKyTFfOsyde0g80YyZBbZZu0GA7x4k09I06Z7MX6R1gKrjKP0Pag==
X-Received: by 2002:a2e:b895:: with SMTP id r21mr7293919ljp.126.1583036185172;
        Sat, 29 Feb 2020 20:16:25 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a17sm1118378ljk.42.2020.02.29.20.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Feb 2020 20:16:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v5 3/3] arm64: dts: meson: add support for the SmartLabs
 SML-5442TW
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <1jpndxgxqi.fsf@starbuckisacylon.baylibre.com>
Date:   Sun, 1 Mar 2020 08:16:20 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E2FA81A-9A24-433D-A674-C0C224FCB2DE@gmail.com>
References: <1582979124-82363-1-git-send-email-christianshewitt@gmail.com>
 <1582979124-82363-4-git-send-email-christianshewitt@gmail.com>
 <1jpndxgxqi.fsf@starbuckisacylon.baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 29 Feb 2020, at 8:32 pm, Jerome Brunet <jbrunet@baylibre.com> =
wrote:

[snip]

> The above does not compile against kevin's tree:
> 1# the audio dt device have not been added yet
> 2# the bindings deps of 3 different subsystem will be available in =
this
> tree with the next rc1
>=20
> I warned about this on IRC.

Sorry.. I saw notices on the mailing list that Mark Brown had applied=20
changes and assumed this meant that audio things would be available
for use. I=E2=80=99ll resubmit a v6 series without the audio nodes and =
wait for
the audio changes to percolate through.

Christian=
