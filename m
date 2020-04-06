Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93CEC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E672215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwQ7UE3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgDFMX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:23:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41511 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgDFMX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:23:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id i3so12557968qtv.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/1a6IzRWH3Bp68ngpAFzn1GZxWmPuagYB/FM5XN8n8=;
        b=RwQ7UE3uKijyujaf1aHIBMT9zcsnYDp3aFA5Ilz4KH5WRW+qe8Ultq3NBcpANjyMar
         UDafw0FlEdplC8iUOPgTXtYLCik3h7K+bVBWQowgWX8f4JTQzmwFoBEYpdomU4L7t4+M
         AearwnEsHnUsZ46nh6PIcToTgzMXLgW+hd8smlk6ds7seRIqW25N7AGMC1RQrGLKj9ZN
         a3mkeLR+XyA9A4bKRSxLQLe+lOJmZAlqXBU4gMqyh698hlizcJUV+Z9ucEq1Pofc9OL0
         YTjILpiwYcEJvDRLALWkryL2XOTCZ3Ruae/FyEvvfKTW2FvSiD8uC/5CNwDIO5inafDT
         1sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/1a6IzRWH3Bp68ngpAFzn1GZxWmPuagYB/FM5XN8n8=;
        b=rCe8fj/xYduyZWOrbX89Up13K+KvqHzdF49/BkUMLPyyfWF+siPkiQDB9ZfqrZ/EXA
         reNKX4Ss6PSxZ8ELGocONcqH/UAuEP4NOVvaBhx3xp3zRB7JB+JIN8chyJr/Y4/n4muB
         xfTxSsWlPTDIBSN4Y3wJlZqkLP9dRuHtDN7PfzeSJAQXpeoufLPirnMwEZGs5cL1ZnAu
         nuEZmJvNK1HQnBEYy4zeSVQaVZU7U8KHISjknR9izw0Epmr07f054oiyMsDD1sBn1Lo4
         Ca0Ym91NAXvtaBBIiWkadB/kMDr4uiLagY8tU4Qma4JgsIOp2EGnhzEN+qJUwawNoqsA
         aivg==
X-Gm-Message-State: AGi0PuZeivL32WBh99oFtv/mnVAUtmgyaGcwOykYS3qa9EtxiCGyBY0b
        PiJoCmfar1+Dyw+3N2Rihtv3883t6wqJiYBVT6iWyWeJ
X-Google-Smtp-Source: APiQypLzs60Chii58DCEWwOXFmsiFc2iWi42Ai0IK4/jCiWYM1+2tzvL5fYGv+a12HFPLgrHONMbwMT0vD5mRmG/qCo=
X-Received: by 2002:ac8:6051:: with SMTP id k17mr20812938qtm.163.1586175836291;
 Mon, 06 Apr 2020 05:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200404125845.1381080-1-gch981213@gmail.com> <CAJsYDVLA3fgjBGdStkiZeqEv8q2j2sUdDzgj3QdahB=tvyYJWg@mail.gmail.com>
In-Reply-To: <CAJsYDVLA3fgjBGdStkiZeqEv8q2j2sUdDzgj3QdahB=tvyYJWg@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 6 Apr 2020 14:23:44 +0200
Message-ID: <CAOX2RU7ZU0Jj71YCAoP=qaqUomaHKTi=XMV8wGvwRg_fYpfoMg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mtd: spi-nor: Add 4B_OPCODES flag to w25q256"
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004629d405a29e57db"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004629d405a29e57db
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Apr 2020 at 07:18, Chuanhong Guo <gch981213@gmail.com> wrote:
>
> Hi Robert!
>
> On Sat, Apr 4, 2020 at 9:01 PM Chuanhong Guo <gch981213@gmail.com> wrote:
> > "line over 80 characters" warning produced by checkpatch.pl isn't
> > fixed because I think a revert commit should bring a file back to
> > what it was before.
> > I don't have a w25q256jv available and can't compare SFDP table
> > to create a fix similar to mx25l25635 one.
>
> I just tried and unable to dump SFDP on my W25Q256FV,
> probably because my chip is too old to have one.
> Could you check if your W25Q256JV has this and dump it?
> Just add some prints in spi_nor_read_sfdp.
> If a 4-byte address instruction table is present, current kernel
> should be able to discover 4B_OPCODES support automatically.
> Even if that's not the case we may still be able to distinguish
> W25Q256FV and W25Q256JV using SFDP table.

It appears that W25Q256JV has an SFDP table and in it advertises 3B or 4B modes.
>
> [    1.957903] spi_qup 78b5000.spi: IN:block:16, fifo:64, OUT:block:16, fifo:64
> [    1.962185] SFDP advertises 3B or 4B
> [    1.977393] spi-nor spi0.0: w25q256 (32768 Kbytes)
>
I have used the attached patch to check what does the SFDP DWORD 1 advertises.
If FV version has or does not advertise 4B support than that can be
used to differentiate them.
Can you apply this patch and check what the FV version advertises as I
don't have a device using that revision.
FV version also should have SFDP as datasheet for it clearly advertises is.

Best regards
Robert
>
> --
> Regards,
> Chuanhong Guo

--0000000000004629d405a29e57db
Content-Type: text/x-patch; charset="US-ASCII"; name="999-spi-nor-w25q256-sfdp.patch"
Content-Disposition: attachment; filename="999-spi-nor-w25q256-sfdp.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8og0x190>
X-Attachment-Id: f_k8og0x190

RnJvbSBiMjk5MmI4ZWM2MDdkYzY3MDRlYjliOGRhOWE5Mzc4OTRhNDA2ZDg1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JlcnQgTWFya28gPHJvYmVydC5tYXJrb0BzYXJ0dXJhLmhy
PgpEYXRlOiBNb24sIDYgQXByIDIwMjAgMTM6NTI6MDcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBz
cGktbm9yOiB3MjVxMjU2IHNmZHAKClNpZ25lZC1vZmYtYnk6IFJvYmVydCBNYXJrbyA8cm9iZXJ0
Lm1hcmtvQHNhcnR1cmEuaHI+Ci0tLQogZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAz
NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDM2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9z
cGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jCmluZGV4IGY0
MTdmYjY4MGNkOC4uMDlhNGE4YmNlMDdmIDEwMDY0NAotLS0gYS9kcml2ZXJzL210ZC9zcGktbm9y
L3NwaS1ub3IuYworKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYwpAQCAtMjE0Myw2
ICsyMTQzLDQwIEBAIHN0YXRpYyBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgZ2QyNXEyNTZfZml4dXBz
ID0gewogCS5kZWZhdWx0X2luaXQgPSBnZDI1cTI1Nl9kZWZhdWx0X2luaXQsCiB9OwogCitzdGF0
aWMgaW50Cit3MjVxMjU2X3Bvc3RfYmZwdF9maXh1cHMoc3RydWN0IHNwaV9ub3IgKm5vciwKKwkJ
CSAgICBjb25zdCBzdHJ1Y3Qgc2ZkcF9wYXJhbWV0ZXJfaGVhZGVyICpiZnB0X2hlYWRlciwKKwkJ
CSAgICBjb25zdCBzdHJ1Y3Qgc2ZkcF9iZnB0ICpiZnB0LAorCQkJICAgIHN0cnVjdCBzcGlfbm9y
X2ZsYXNoX3BhcmFtZXRlciAqcGFyYW1zKQoreworCS8qCisJICogVzI1UTI1NkpWIGZ1bGx5IHN1
cHBvcnRzIDRCIG9wY29kZXMgYnV0IFcyNVEyNTZGViA0QiBwYWdlIHByb2dyYW0KKwkgKiBpbnN0
cnVjdGlvbiwgY2F1c2luZyB0aGUgZW50aXJlIGZsYXNoIHRvIGJlIHJlYWQtb25seS4KKwkgKiBV
bmZvcnR1bmF0ZWx5LCBXaW5ib25kIGhhcyByZS11c2VkIHRoZSBzYW1lIEpFREVDIElEIGZvciBi
b3RoCisJICogdmFyaWFudHMgd2hpY2ggcHJldmVudHMgdXMgZnJvbSBkZWZpbmluZyBhIG5ldyBl
bnRyeSBpbiB0aGUgcGFydHMKKwkgKiB0YWJsZS4KKwkgKiBXZSBuZWVkIGEgd2F5IHRvIGRpZmZl
cmVudGlhdGUgVzI1UTI1NkpWIGFuZCBXMjVRMjU2RlYuCisJICovCisKKwlpZiAoKGJmcHQtPmR3
b3Jkc1tCRlBUX0RXT1JEKDEpXSAmIEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfTUFTSykgPT0K
KwkJQkZQVF9EV09SRDFfQUREUkVTU19CWVRFU18zX09OTFkpCisJCXByX3dhcm4oIlNGRFAgYWR2
ZXJ0aXNlcyAzQiBvbmx5XG4iKTsKKworCWlmICgoYmZwdC0+ZHdvcmRzW0JGUFRfRFdPUkQoMSld
ICYgQkZQVF9EV09SRDFfQUREUkVTU19CWVRFU19NQVNLKSA9PQorCQlCRlBUX0RXT1JEMV9BRERS
RVNTX0JZVEVTXzNfT1JfNCkKKwkJcHJfd2FybigiU0ZEUCBhZHZlcnRpc2VzIDNCIG9yIDRCXG4i
KTsKKworCWlmICgoYmZwdC0+ZHdvcmRzW0JGUFRfRFdPUkQoMSldICYgQkZQVF9EV09SRDFfQURE
UkVTU19CWVRFU19NQVNLKSA9PQorCQlCRlBUX0RXT1JEMV9BRERSRVNTX0JZVEVTXzRfT05MWSkK
KwkJcHJfd2FybigiU0ZEUCBhZHZlcnRpc2VzIDRCIG9ubHlcbiIpOworCisJcmV0dXJuIDA7Cit9
CisKK3N0YXRpYyBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgdzI1cTI1Nl9maXh1cHMgPSB7CisJLnBv
c3RfYmZwdCA9IHcyNXEyNTZfcG9zdF9iZnB0X2ZpeHVwcywKK307CisKIC8qIE5PVEU6IGRvdWJs
ZSBjaGVjayBjb21tYW5kIHNldHMgYW5kIG1lbW9yeSBvcmdhbml6YXRpb24gd2hlbiB5b3UgYWRk
CiAgKiBtb3JlIG5vciBjaGlwcy4gIFRoaXMgY3VycmVudCBsaXN0IGZvY3Vzc2VzIG9uIG5ld2Vy
IGNoaXBzLCB3aGljaAogICogaGF2ZSBiZWVuIGNvbnZlcmdpbmcgb24gY29tbWFuZCBzZXRzIHdo
aWNoIGluY2x1ZGluZyBKRURFQyBJRC4KQEAgLTI0ODAsNyArMjUxNCw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZmxhc2hfaW5mbyBzcGlfbm9yX2lkc1tdID0gewogCXsgIncyNXE4MCIsIElORk8o
MHhlZjUwMTQsIDAsIDY0ICogMTAyNCwgIDE2LCBTRUNUXzRLKSB9LAogCXsgIncyNXE4MGJsIiwg
SU5GTygweGVmNDAxNCwgMCwgNjQgKiAxMDI0LCAgMTYsIFNFQ1RfNEspIH0sCiAJeyAidzI1cTEy
OCIsIElORk8oMHhlZjQwMTgsIDAsIDY0ICogMTAyNCwgMjU2LCBTRUNUXzRLKSB9LAotCXsgIncy
NXEyNTYiLCBJTkZPKDB4ZWY0MDE5LCAwLCA2NCAqIDEwMjQsIDUxMiwgU0VDVF80SyB8IFNQSV9O
T1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sCisJeyAidzI1cTI1NiIsIElORk8o
MHhlZjQwMTksIDAsIDY0ICogMTAyNCwgNTEyLCBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQg
fCBTUElfTk9SX1FVQURfUkVBRCkKKwkJCQkuZml4dXBzID0gJncyNXEyNTZfZml4dXBzLCB9LAog
CXsgIncyNXEyNTZqdm0iLCBJTkZPKDB4ZWY3MDE5LCAwLCA2NCAqIDEwMjQsIDUxMiwKIAkJCSAg
ICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sCiAJ
eyAidzI1bTUxMmp2IiwgSU5GTygweGVmNzExOSwgMCwgNjQgKiAxMDI0LCAxMDI0LAotLSAKMi4y
Ni4wCgo=
--0000000000004629d405a29e57db--
