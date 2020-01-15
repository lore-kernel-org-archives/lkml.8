Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF48C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26922084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RFotpcZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAOTAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:00:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45765 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgAOTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:00:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so8928803pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ui/LHNZMNuxDFZkSvHwprhXUW0PBXFzrYgBctU22yUk=;
        b=RFotpcZpcL068jSpVnwAw7Tb0V79YklyPf9r3U9n25i0uSCdk9GdBJmSkYKXEvDqO8
         uRAcs0iIKe+cgrjUKiH+bkdjcK561SNGQu2VzKNeJVnn0CdtLMeANvj7mPlEx6DKKuv2
         70r2yu17/FLoRJtCxmhZKz7qIaGBMV1LKdFt4PQcmh3OCk/ScgOfnTxnVFGdXs65XYP+
         oz6dl1C0L3FMgT/9EjiyZvQsHhiBhR0v7FMdKJccAZ53g+KdvpPBp3Cf78+AQwGCbDQS
         fnzjDXK0yHA7r/qCyHXsii23baUamYtRxDFWeQvqBSxmkOiO/4y/SD1sWQEkSpdm5eFg
         7Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ui/LHNZMNuxDFZkSvHwprhXUW0PBXFzrYgBctU22yUk=;
        b=gknGLAPmyHRfxqBx1tfhd3wUkGTP38NWDVx3QKafeIwS2f/e6CEt5uU8AKBjxfTLZK
         LO3uTFfOLVv4BDSHzYe+4ZiVfJRweq++kn6r8Gm28NUXR51h93in91bGeXeDnY1DwAAU
         w0ZmTqCWvAlde6td0rerN7z4SmHB6AlJ7+uQP2RhGgCY+Ge3WfcOT0eRQ719wD+G2L+t
         DYrMDtPqncpnh4Cmf1xw4a+oNBA4D5YVGADt/GkGLsjZ4Tb9b3l2J3+RfNlvzSnAJfHq
         0OBZGKe/1Uexaty2D4O+iGDZBcvZfol9tPUXn4FHRv1KqRRjcOL6N9vYsHjNC41Mi4W4
         kHDg==
X-Gm-Message-State: APjAAAX28oKJv3p7wDnlvYweF28djfrwTPYRY+Y2Dk4Wpl7a4/5iU0ot
        owPik+cVLwvqCXYy4XMb3D6mpQ==
X-Google-Smtp-Source: APXvYqwy72jUsm+n4BdxGsJTuXS8ExkE3jPC6QBNdo0J7hKBsao31DPs/GIz18rTX1MewhKPip3TWg==
X-Received: by 2002:aa7:8d14:: with SMTP id j20mr33695263pfe.207.1579114832707;
        Wed, 15 Jan 2020 11:00:32 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:ddf6:ea5e:27c4:ee20? ([2601:646:c200:1ef2:ddf6:ea5e:27c4:ee20])
        by smtp.gmail.com with ESMTPSA id b19sm22066961pfo.56.2020.01.15.11.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:00:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Fix built-in early-load Intel microcode alignment
Date:   Wed, 15 Jan 2020 11:00:29 -0800
Message-Id: <5C216684-6FDF-41B5-9F51-89DC295F6DDC@amacapital.net>
References: <CACMCwJLJCA2iXS0QMKKAWQv252oUcmfsNvwDNP5+4Z_9VB-rTg@mail.gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
In-Reply-To: <CACMCwJLJCA2iXS0QMKKAWQv252oUcmfsNvwDNP5+4Z_9VB-rTg@mail.gmail.com>
To:     Jari Ruusu <jari.ruusu@gmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2020, at 10:46 AM, Jari Ruusu <jari.ruusu@gmail.com> wrote:
>=20
> =EF=BB=BFOn 1/15/20, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>> On Mon, Jan 13, 2020 at 09:58:25PM +0200, Jari Ruusu wrote:
>>> Before that 16-byte alignment patch was applied, my only one
>>> microcode built-in BLOB was "accidentally" 16-byte aligned.
>>=20
>> How did it accidentially get 16-byte aligned?
>=20
> Old code aligned it to 8-bytes.
> There is 50/50-chance of it also being 16-byte aligned.
> So it ended up being both 8-byte and 16-byte aligned.
>=20
>> Also, how do you *know* something is broken right now?
>=20
> I haven't spotted brokenness in Linux microcode loader other
> than that small alignment issue.
>=20
> However, I can confirm that there are 2 microcode updates newer
> than what my laptop computer's latest BIOS includes. Both newer
> ones (20191115 and 20191112) are unstable on my laptop computer
> i5-7200U (fam 6 model 142 step 9 pf 0x80). Hard lockups with both
> of them. Back to BIOS microcode for now.
>=20

Hard lockup when loaded or hard lockup after loading?

> --=20
> Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F1=
89
