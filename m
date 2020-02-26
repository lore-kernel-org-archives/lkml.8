Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86FAC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC4621556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDw0SIaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgBZI2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:28:42 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:38503 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBZI2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:28:41 -0500
Received: by mail-qt1-f180.google.com with SMTP id i23so1662787qtr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 00:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=TCKiJfk1tuX6JcQsxBCHZJ/LwaPkV6Zrs8OdjgYk6a0=;
        b=CDw0SIaWUZSx7ENi65bSwjHzQAWLf217RuK8tOjLweGrxEljFC5e2v65jurQ2QrUVk
         +5HfROicgsDND0ECwSUtjOPXCq42smEuX7j9ckuDcTb6gLPAs7m+Pm/rnBnw8xtdpz2/
         U1IAm27CYn2i2+TH4wS1dbs+d73vyMf4x0H6qc0vYg2V9liVP/0U/LjbWqD00lKPcaH+
         EaqkEnYkk2TP8LSMxJOzJ9QsnzYTEQKXWZ9yJXWzmA4cNHYuroGM5BKMZdh9aICwYceV
         pU4/8Rh+89HE2w6vX4ACzsGX/aYgrdm3Gj4rgLLttLxK5IT7M3oGhC7+VbGAH24nD01e
         /jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=TCKiJfk1tuX6JcQsxBCHZJ/LwaPkV6Zrs8OdjgYk6a0=;
        b=cum1FucxH+B1chjIxh1gvxTWd2uCXdHhwUx1/9+pWn/qk+iEhJSxNaEChEZR5LuX5R
         TbW31erdlmrNb6fGVqL+vm2xmUSMaW79JE3TVsIn7OggBdzOaxehH6JWJffXzRCurE5t
         J4VnbDwtbSXYOHSSxLtmvKYRoW8csGRzrDot4Fda0moC8sQzdlPnOCNrlNujZyOT7MbN
         OQVqFg5USKJ/MfMZ51YnMNf2Qzgi3lzD0vydiSp5MQf6aUu54H7z/fmhNxhhW+FoD/KD
         XEGugfkztozj/GuqB1J0xAMOffPd5xPqF6ujcuskWFZ4z+Ui75SMZAfTloh2/vppNP5/
         c77g==
X-Gm-Message-State: APjAAAUm8XPDP7lb6Bj8q4V2VqgbKBqf1RZezc5gHpqjs9vhFiAEW182
        i164oQneKADmIIOQ/dp963tYeuKxusHRpaMujwE+XgW/g9zb0Q==
X-Google-Smtp-Source: APXvYqzIvgC0UaVeAAwn2e2tklNhtMrCKv0uUcP6KZReoNaHA+YKvaS0da2RRppS9PoApOf/RXdhr8C/6c5EUk+kF2A=
X-Received: by 2002:ac8:7159:: with SMTP id h25mr3593895qtp.380.1582705720488;
 Wed, 26 Feb 2020 00:28:40 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Feb 2020 09:28:29 +0100
Message-ID: <CACT4Y+Yezqn1JZac9=R1dmgZ4d6N1btAsP6AHON-Cds1knTaiA@mail.gmail.com>
Subject: public gerrit instance for kernel
To:     workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Ben Gardon <bgardon@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've setup a public Gerrit instance for use with Linux kernel development:
https://linux.googlesource.com/Documentation/#gerrit-code-reviews-for-the-l=
inux-kernel

After one-time setup changes can be pushed with a single command:
$ git push gerrit-net HEAD:refs/for/master

Gerrit has several (subjective) benefits over email-based reviews:
 - full context (you can expand more context as necessary)
 - diffs between version, e.g. full change is +547 lines:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2=
265/2
but diff between v1 and v2 is just 2 empty lines:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2=
265/1..2
(no need to write that up, trust subjective write ups)
 - colored side-by-side diffs, e.g. here you can easily see that even
that line has changed it's only slash at the end that's added:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2=
103/1/kunit/Makefile#2
 - marking files as "reviewed", always correct base tree/revision, etc

But note there is no "official" story for gerrit in the linux process.
You may use it as you find fit. Some uses that we found useful so far:
 - upload to do self-pre-review
 - review within a team of people who agree to use gerrit
 - include a link to gerrit into the upstream patch email as FYI
(after =E2=80=9C---=E2=80=9D line)
 - upload somebody else patch just to review with side-by-side diffs
and full context

The branches are mirrored automatically from kernel.org; you can
upload changes for review against those branches, but submission has
to be routed through the traditional process.

If you are brave enough, you may use a gerrit-managed tree as well,
then with ability to merge/edit change on the web, non-losing comment
threads attached to lines of code, change status tracking, etc. But
that will need to be setup separately.

There are some improvements planned like not requiring Change-ID and
proxying comments to/from kernel mailing lists. But that's only in
plans now.

Thanks
