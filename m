Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABD1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF972467F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHcIvb4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgAWLOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:14:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33253 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:14:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so2154327qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pIBBB+FyqjefbIxBTNbhDe9jNmYX2Aqjd2a2x8BkoQg=;
        b=fHcIvb4nHeDq9bpWHfhkXZKeBhYlXHkRV3yGtlLI5ChsQq5f+w7vr5gy7O2EOaVGMu
         jU900iVkyCb8zsRhM9i6OcBNlj6gFgBybkSHXJcUtY5WVtqs6JJoF1IDMVjtMjIHWAEx
         M46k4w+hJLlG1iXXm5D0gasabKTeVG09KMBlP4hf+I5XAXxR51LHLtA8fULSve1yqXXV
         ORr8ljn4JQdLZAKWRU1XOM3W48225V+IQM38q6AaCnK5wEq/ew+GqCNsWKnd6kA5EQJY
         djokP+W0Xww7keljpDLu2zWnn7iMbWP7QT9Z4GF7dh4+fS/dzPPL0z/c39103EFW5rNu
         8JeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pIBBB+FyqjefbIxBTNbhDe9jNmYX2Aqjd2a2x8BkoQg=;
        b=KHTx/aVb8vbrqRvHF46tL0Kvw7PKmPnTdoDeuWNySbG2Vb/nVTQZL92HqaM6b10QV7
         j9nd1CjM0BmiW5bKt9rGCsja2Qrs/JArtOvpkaK2lwy4Ji2GaaMGvC4TIFx9Ubg4FUY9
         L39Y5+0J1MmN6xWgLR5cSJ5v7euBxRQNKND7tH9VmhkdnVghXpi4liYu37p4HKme3U3f
         W1hemUHSSBgQ2e2ciL1TgBQSNssvqpRYc/YtNbDVYAkjdFwVL5tM6NU6C70YMHHeqNYp
         smHuBZNFjUeXtOoglQYnCBxUQtkINYrKK/i3ydUPIYutH9RkjCOR1YtZhzkPF2zM+Qqf
         jVUw==
X-Gm-Message-State: APjAAAW6/UAW6SNMHYILeLwkgEpRbGw7aCzfNTx4pEO3UQWeM9PO/iP3
        OC/aDjQlruWlCKDV5/dbmJD4bm0WCcpczY94GGjFX2Ll
X-Google-Smtp-Source: APXvYqwMOYxbq9s8t1R7V20l9CZKWcQWeyJQ8QLtzxZaNJ9mGeMlR3UyN+Tj5pvjeII9HGCRsKH9gvA4iA8XBMUaKic=
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr15125122qtn.156.1579778043087;
 Thu, 23 Jan 2020 03:14:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:678d:0:0:0:0:0 with HTTP; Thu, 23 Jan 2020 03:14:02
 -0800 (PST)
From:   patrick goutain <goutainpatrick@gmail.com>
Date:   Thu, 23 Jan 2020 12:14:02 +0100
Message-ID: <CAFj==g1D3Q2n4LtZoU88KyenwybcEzQ92SqM3zpu5gWoB3ehjQ@mail.gmail.com>
Subject: Kreditangebot
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo
Kreditangebot f=C3=BCr Unternehmen und Privatpersonen, um den reibungslosen
Ablauf Ihrer Investitionen zu gew=C3=A4hrleisten.
Wir sind spezialisiert auf den Bereich der Finanzierung, Wir bieten
unsere Dienstleistungen allen Personen mit gutem Charakter und vor
allem in der Lage, ihren Verpflichtungen nachzukommen.
Wir sind in allen folgenden F=C3=B6rderbereichen t=C3=A4tig:  Ausleihe:
Pers=C3=B6nlich, Konsolidierung, Renovierung, Kommerziell, Student, Auto,
Sonstige / Sonstiges, Gesch=C3=A4ftlich, Landwirtschaft, Computer,
Geistiges Eigentum, Dienstleistungsunternehmen, Industriell, K=C3=BCnstler,
Mode, Medizin, Medien, Hypothek, Immobilien
Sie k=C3=B6nnen einen Kredit von 5.000 =E2=82=AC bis 10.000.000 =E2=82=AC b=
eantragen, wenn
Sie ein Unternehmen sind.
Der Zinssatz betr=C3=A4gt 3%, und die R=C3=BCckzahlungsfrist betr=C3=A4gt 1=
 bis 30 Jahre.
Es wird eine gro=C3=9Fe Freude f=C3=BCr uns, wenn Sie finanziell stabil sin=
d.
F=C3=BCllen Sie dieses Formular aus, Und senden Sie es an unser Adressfeld =
zur=C3=BCck:

Vorname: ....
Name:=E2=80=A6 ..
Stadt: =E2=80=A6=E2=80=A6=E2=80=A6
Postleitzahl: =E2=80=A6=E2=80=A6
Status: =E2=80=A6=E2=80=A6=E2=80=A6
Land: =E2=80=A6=E2=80=A6=E2=80=A6
Geburtsdatum:=E2=80=A6
Telefon: =E2=80=A6=E2=80=A6 ..
Familienstand: =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6 ..
Beruf: =E2=80=A6=E2=80=A6
Darlehensbetrag: =E2=80=A6=E2=80=A6
Laufzeit der Kreditr=C3=BCckzahlung: =E2=80=A6=E2=80=A6 ...........
Monatliches Einkommen:=E2=80=A6 ..

e-mail. financementauto51@gmail.com
Danke.
