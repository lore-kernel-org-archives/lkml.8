Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A574C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 08:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3120707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 08:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Jslwk158"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEaIDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 04:03:43 -0400
Received: from mout.web.de ([217.72.192.78]:40497 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEaIDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 04:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590912202;
        bh=q/tORPlp0EWYnt9tH2UDu/psahHRfi5vrlOUO7gRk6A=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Jslwk158HDn8feV2zm40UcP8RTy8Si18gKEXCh4aPOEhIE01zwPU/hpGTCOfdEwYj
         oKYPvKNZ8jnIB32ck6hIPBYUIvCwtQHlpmHdZBNK3RSakBKPGZr4ZZV98kouUI+4A9
         zrDqOlGtLiu03mmkOWhDBnNcYE0MIyQZs+cfEMjw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.19.10]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEeC-1jltac1Wum-00FUaX; Sun, 31
 May 2020 10:03:22 +0200
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] drm/nouveau/clk/gm20b: Fix memory leak in gm20b_clk_new()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dd729c13-fbc8-22e7-7d8e-e3e126f66943@web.de>
Date:   Sun, 31 May 2020 10:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MNpT3jpEJ7iDEs22X5lh4tM5OD6V+jbje/KJ0Az3/6eS/4fsxvM
 IRHXN0vVlVmychsnkc3b7CWsN1UEopW8QPW+Ko2KCdTz/if7eLBLiu08FiSKuHVpZquCI0e
 3e6ZNQTnzxt9CUdA46i1b7AOXhON6TLVskEmk12jWS+fnRoddyHWfAAmg9/I6nIXm2/QYqc
 YMhizRSW6Hn973BPyk8JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W42QECcB9I8=:TtJX7zUA2NH/Iqd4cu1r89
 LffOy42Bch6shaA5pP/hGmXucAO5ZGW5Tfq+K/gHOwtlcEZYgR/SUsXclyrFondFB9WYdBou2
 nNCkup1esGZPXooYYVDm9WohuGsPyPR5xk9QKN0dpL7WnQyA4lKAfIRDQpuvl0PG4GER2xoaR
 y0OP+2iswH4U+Htmso1pm/RJ57DOuALFMRjDg9xVVDFW6HCN1M2kDIebBEcxtTgoY6loIJ0IC
 Haeaq9OvhpaRgj1gYyAFBS0afeCKJBbEd2Uc5lZdzBp+eq8ZBeTcZ9FniI+am4ZG6djhm8uPw
 DEDeNCAq1jwCa5yt4+LzGQt89u7QERzN+fjM+fqTSHDM5B4l9vOZ9nHd2AMcsUVPZMUrG8LQv
 baqaj74DY+oMhGSMsJe5A0Se9N5WKPALiHFCE7hCsFsT6ex7XKEluiHd6IJq9FSmgYi3lEZ7y
 hLL7I91igk3T6Fd7Njtp6hcGWV0ACNRa3AnV60oEECUJ5ibyH9+KK8tS6SIiWip+cYsmS84iI
 sSfwhvyoKYQN6C0Q+kFj8ZWJ8KxeIoWVZz44YmZ9k53bHC+Xl//YIGg7dbzVGy346CXh8CECY
 yHTjsEdynDvUAKli6ROzO31AVonr245kIY66Q99RlP0GIwPihZk3GadtN7D3hGIGtfs4c2zHN
 JKgiDTdhS7sHLadv9+S34967BtpBgeAuWCCK+Lo+W61OMNewOhop/1Y1FBsszGSLP5UINGrua
 Q/8Dw33i3gQkMazw8E0LYiDPEPNnt3vuC/ArkaUn3PcwEgNfw1J+D8p189sZ8TNx6nRQ1mvzy
 KAr1Ysr+gr1BmdFfs4BRkK2FagedqMcyktW/ScPcgFrv3CtucmY7wZPc9zOEF3PpIQdmfXCPV
 NO8BqQMIrQx2U5PbIKG0uPmG4ElMabToB0nQe3v9unfVCqPhj9jT/cxLmOSAiEZKLcJdA09Kc
 rBvdiQ7A08llaVPZZXnTxEEDnbUnK4C0IwGB4/6hdLXqDduyf9xP1WMtFYfYVCx2DofE8K4lv
 mfMUoKkWrm4HGeZJ3NZyAK6SAgHtA0ILOoexYjDKxXC9yuBXMcUDSu8Vc7zm0/nRFDy1tI730
 fzluCZcq6cF0FxK3jP5aGSMwlCsx8FR5Sm8MYlV5em9wz0/gvH/J3tSA14jtk4G46Ey9vNMeZ
 jrLj60Fjh3m9tp2Ya3BbURfTXffTFZkkXjw5kCbg2u5E1LY1zW4cz5RV6Xmm+4Z/HSjZdRlrX
 uWNfibm/3h+xWp1mc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When gk20a_clk_ctor() returns an error code, pointer "clk"
> should be released.

Such an information is reasonable.


> It's the same when gm20b_clk_new() returns from elsewhere following this=
 call.

I suggest to reconsider the interpretation of the software situation once =
more.
Can it be that the allocated clock object should be kept usable even after
a successful return from this function?


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
