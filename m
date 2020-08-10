Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA4BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 05:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3F2206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 05:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Oqakvl6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgHJFkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 01:40:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:58783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgHJFkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 01:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597037977;
        bh=pLncW+jsTSqwL2/XFxBd7F5/jdIdJnDnczpYfxUFrHM=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=Oqakvl6bHX3ulQwioK1Kp46rWFK8aLjIv6l1rN0OB87EXMDJkjcteccKZT3SiPToS
         N0tqMRZWikFcsWAAeiv2UL4D7JfV3C0E7rsuzElz4K2LK998q7Osldf/hokJCvCzOQ
         HeOnI5fHrnoDJaWcbgj9NSqyKLyBalP3Ei/IfCCU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([37.60.4.172]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbW0-1jvfGw3I0E-00H73E; Mon, 10
 Aug 2020 07:39:36 +0200
Date:   Mon, 10 Aug 2020 07:39:32 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAOTY_-DYsbAWkdKfiGeJOwmPUOO1T+6WmOmhDQEUbzoRh+KPw@mail.gmail.com>
References: <20200807082754.6790-1-linux@fw-web.de> <20200807082754.6790-2-linux@fw-web.de> <trinity-f5a5deb1-c123-44d7-b7ca-1f7a8dbe1c1c-1596889651064@3c-app-gmx-bap69> <CAAOTY_9o_hBWxWBdDoeeJ6zuV4rb4R_yEoN5+L0uHBGMw4Kduw@mail.gmail.com> <81DFA743-B455-498F-B2F2-161DD9D51F57@public-files.de> <CAAOTY_-DYsbAWkdKfiGeJOwmPUOO1T+6WmOmhDQEUbzoRh+KPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] arm: dts: mt7623: move more display-related nodes to mt7623n.dtsi
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <F446502F-E898-465C-9273-813CD032B40F@public-files.de>
X-Provags-ID: V03:K1:5IVYYxOkmECFWiGF+n4+3P6wuzhQjm/Mwi6B6QcyROBdlqK+Xyv
 qGLxbENEomX3fdARW2G1IrCKDsKVoGwag9vcdwl3A8L3DxlC6sYMe9XWdIrshdkxig+a2MS
 N+7JBeLAvN88QJ8AkyL+qo9SRo2hFT28DWerRjlLrf4Edny8i86CVHt7HDWGvWCB8pTbCwX
 q7CNSqs/0jSGwHCIcI39A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fCEvVk70z04=:UB7jVjv5E0mU8AovmEO0k8
 d+s9k2krktemNdv0J5Vxs3lBepHgF+/xjc/KsDwoCNGaeBldlL+9mV/D1G7xL5lMnREUsGsz4
 R2hUWrnxrrSYtm5UdvERUwk0DyqGXwxJjRatuUciccPaj9cFFCBx1kJJGC6wDnikOmWveVuOz
 M45oEhoJUy3DikE1I3l1Fcbhdm3FehYksrYSDXk7ywo+nDlmHbwPrQWlGZtEmTj8WqapgxPK6
 X+FA53QjGBN0jKCXvagIOCGMLI8ZGJozZicV/wZO0vDIhWuLEQMT9NyC4PHyypulnWvWrN8bt
 2bkpIZe2fLCFkyNvucMGJW/z0WLadrtx5UnARD4FmL0bjiS0sP/I5+kVxOok2k8KHkV3Oxa5/
 a4ynD8hxd0T/FROjIRLFS1bXnTKh2OAA63mF+wAR3wNRWz3OMf065jM9RSdTQHPAsvT5ik2VH
 +HuC3djEAtZn2QzzPnUXq7c1CnUfhSRuTbD/idI3yNvqfRak4HOu+zhfttLHm99u98NNQh3C4
 isO0JCqfuh6eHTINuUlqlmARFwBa8vvNnLFT5urELaQu/oNqieVvuL65L4KkoQrBKxc7mkviN
 97+Gva3NqTEmHKDEgYesVu9YJErNf56TT/zGa6qx9sYL6Rqw699+sFUN0jqmuGLfDKUmARNzU
 1W7INJJaQK1/pp7W9kSiCwSdJTWhJaJx1nyslYTOUxtPpmksTp82OwrGOInqMx3r/1mWV1KHg
 ah4SZ1cqyFoUbh4fz0ZshyYsLPLYt1kdAAaC9HgLF5t4oSxvItOl/RM9hc7qce1yuBl6zJXV/
 UPw4vOq46ECBkOhMMsz+lnRwn9xa6b/vYcvC4/JIgvQbuKVvsiRxCp6OdhwI2bd98Vi5hzGqq
 v0RVrY0O7MQV7fZGcCGVMFYVrgLbd4qCYtsGEPReeBCY1rVg05CToO2qO+dlFQiGhe3Ys/sf6
 7CuhjEAC0Atu1ygE9i1g2k85Nsp81rd5ssLJxNKbH/mNhnuSmRZzLgxwCsBl8kJ/VT2dmCkJM
 oquIoZoZidpPx7CehiLzYIxFojqcKFDC8RtqQMUkgnb3hsdRhUSnk82swDL30aAkprnChVH7p
 w2YiCSdoHcU3W26XZtVkQGXiPr6A4cDxt1QpeWRgIwqqJWPAFwZQKpBCbun4qMMxNe87u65kw
 qVu/jnUN5/oANfjLWsmq5YaXlAwWI7oZjGYG6Bw6hy2ZvzJ5wt0gfhP/XjuWGedSf7B8am1QA
 +Er7mpeqwUuIswYVxmhWoxQvhvHJrNnszZp3xTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 10=2E August 2020 02:06:27 MESZ schrieb Chun-Kuang Hu <chunkuang=2Ehu@k=
ernel=2Eorg>:

>Alphabetical order is better=2E
In dts there is alphabetical order but not yet in dtsi=2E=2E=2Ei try to fi=
x this=2E

>> Is the tmds Patch ok? (because review missing)
>https://patchwork=2Ekernel=2Eorg/patch/11700679/
>
>That patch looks really like a hack patch=2E I would wait for a long
>time to see whether any one has comment for this=2E Or you could have a
>better explain for it=2E
As i have documentation for mt7623 and there were no further comments on o=
ld series (https://patchwork=2Ekernel=2Eorg/patch/10903303/) i guess i cann=
ot fix this=2E I only know it is needed to get clear image on my 1280x1024 =
display with this Patch

I adressed Ryder and Bibby directly maybe they can help here

>I could apply other patches first=2E

I guess i need to fix order in dtsi first=2E=2E=2Eafair any hdmi node crea=
tes an serial device moved the others +1=2E So maybe nodes need to be added=
 after uartx (or at least the one if i found out which)=2E
regards Frank
