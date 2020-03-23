Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC56FC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E9720736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgCWIwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:52:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCWIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:52:06 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mfpf7-1jjHuG1e8H-00gL5M for <linux-kernel@vger.kernel.org>; Mon, 23 Mar
 2020 09:52:05 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 32D9C650400
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RfibddZr982P for <linux-kernel@vger.kernel.org>;
        Mon, 23 Mar 2020 09:52:04 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id E06EF64D257
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:52:04 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.4) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Mar 2020 09:52:04 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id ED162804FB; Mon, 23 Mar 2020 09:50:00 +0100 (CET)
Date:   Mon, 23 Mar 2020 09:50:00 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] arm64: dts: renesas: salvator: add a connection
 from adv748x codec (HDMI input) to the R-Car SoC
Message-ID: <20200323085000.GE4298@pflmari>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <cover.1584720678.git.alexander.riesen@cetitec.com>
 <077a97942890b79fef2b271e889055fc07c74939.1584720678.git.alexander.riesen@cetitec.com>
 <CAMuHMdXiG1upHQrCcuZgNLFOEoeDVcb0zWxh1BZZST5TOURDBQ@mail.gmail.com>
 <20200323084011.GC4298@pflmari>
 <CAMuHMdXa96P+boX9HgGMBKEXLKK91t3Jgu-Sy8mP5A5--EeP=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXa96P+boX9HgGMBKEXLKK91t3Jgu-Sy8mP5A5--EeP=A@mail.gmail.com>
X-Originating-IP: [10.8.5.4]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7066
X-Provags-ID: V03:K1:Sn/v4TLN01iqgWqz4R0BIbcbhuehlRVU+b7I3pJVJbjnkE5YfXs
 YyxZWIiS7q6zf87lSN134OVGxomlhA+aMd9xOThDYKxvpTHqUnfmZyDrkNUtzLspHXBeX2z
 dr3igpjjYton0EwvIIwLyoUb+7iqmt4otmrQWwxfpYCDn4c1mDTMFe+9gPNQ/HQ5wU+ISfu
 H1SCTe3qp0M9EpZcdh2qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fhGJnbIwD+E=:6RBTaUTgBMT4Qu1vSqzFOv
 5UkCMw/1lYPtw2PmhYcjg4IC9hVOnvjut8kH1voo+1UaceaXUSw2alt+pSApjrYQntPkyIH8d
 0rR+e9qRV5BSb4cEVvdjDOnybn71KaJ/4bkU/+VISAKC/7VVWQF1ySIOys17kCwe+HKPKnNKM
 tA2ThX6xc+J6gv4ZXRQM7yp5k1RluX+IoHgp3xb3hF7j9Zs5DHIV+Qv2s1fH73Dmihavt5QNJ
 4r+3Tznvo2dCDUPPl7t79sySCxKjrFSROTLi1xaZkumxk+YxxK7ZZ/TL4cwgjt3R5sO/VNk2l
 oeE+rhrPo23dParASWTHY3xDLyFPNbWFGn2vjTtDZJjJC7bod8ZjulLrDKRmoUgc4gOKu/N5e
 Nh9lQdeaeUbitX0eYUtILVQoD4FXcgbKIShZ0zYv5zsw19KAOjCQan9RLLjIvZrD4TrvRWCj2
 l1bYAZAo7Dp9WbdNv46r01mTbDWazvui2IQv/uoKovkzupN92aib7A/0X9pUmb4XTJHPhM0H9
 a61155kaR6apAxL+X/6tPfF+bZ3aBJU9osAQoRp0hrVeJucI/D4apWGi3JcMuDbsr1YVKkhxe
 /N93bOXyysQkdN28gR3soCSWWnhpCxvrERFzVPW/Mdf1RfL2hIY9WQiBxKKxHh5pHoX0nGzGS
 6HW5t1fQeJl+S0EPxC0Um6CL1eJIuKQbbUW5lFhdHgmpURZyK9o/vSk7nafEzqR8aSyjwiRzb
 NQNKFjgeslO1A9eYawpNYls6qJphNGcGxDa8DsqmxFGUN4BqYW+SJgAUorxKxQcnCcx0T3ixF
 dOoUlaNRwpKN+KJ6huU//RXrgTmaVdtkYHqsMGovsLCuzNvztjExblrOIwuRWq8Y6el4Jw8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Geert Uytterhoeven, Mon, Mar 23, 2020 09:48:00 +0100:
> On Mon, Mar 23, 2020 at 9:41 AM Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > Geert Uytterhoeven, Mon, Mar 23, 2020 09:34:45 +0100:
> > > On Fri, Mar 20, 2020 at 5:43 PM Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > >
> > > Did I provide a Reviewed-by?
> > >
> > But you really did provide a lot of very useful information and it did help
> > to improve the code. Shall I remove the tag still?
> 
> Please do so.
> 
> While I can point out issues in audio patches, my audio-foo is not strong
> enough to provide an R-B, and I'll rely on the R-bs provided by others.

Done. I left the suggested-bys in the trailer. Hope those are alright.

Regards,
Alex

