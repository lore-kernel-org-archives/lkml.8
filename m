Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DE6C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAFA2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ge1n7Hvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0Igh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:36:37 -0400
Received: from mout.web.de ([217.72.192.78]:54419 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgD0Igg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587976569;
        bh=s/tAtys+eztFEfxlNS2hN3NLFPw8kpgcny2dkub47zQ=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=Ge1n7HvdOTPuWACR57IdP1i//roAhCBBJOq3GV00TPoA7aJ5oipMm2d6VHLkN0Dg4
         sDWclVE5i3XXoRlTlkRUNMgPTlVuHgqxRS5Uiru+pc2310jnROdnYpJNT7rbG5/6dT
         GMZT9GtLlVjyFURbzuJz3tGDCPLZkPUL/0RsiGuY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.190.48]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lu4uA-1j0uXH0vSw-011OLO; Mon, 27
 Apr 2020 10:36:09 +0200
Cc:     linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shashank Sharma <shashank.sharma@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] drivers/video: cleanup coding style in video a bit
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Bernard Zhao <bernard@vivo.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Message-ID: <9ffb6645-5802-3163-2107-435392a777f6@web.de>
Date:   Mon, 27 Apr 2020 10:36:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tm/WLiArMSAcc240FtcTgGfiSo8WShdR0q9BrpepCzYrsfmLmUN
 X7bOEqYUn83mdu+JCLCKwq7Jht4juKifkcE0cU0w8pF9HsQ6Lct5UShC8an+jUOAmGCNQVT
 60QNZtOVjUUE1fFf5Uhr3jdKEvaJ6uxkLiTjT4+q9VrOtR81uz/vlP2dl3QipqQ2pCc9hbA
 oqpyvvYoM1AZI3pPqC7sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m/Yq0fm1/64=:ERBg3z99BlmrUxekshVz0A
 K1DVkI0C4rboJVIUuGg5coXDgz8YdtwDxoygwH6gljNp4VDFzzVWrHNTG8SyiNmPxQl3ysQ6q
 ZckvttSmBzBxEFpCV1RKG2lQiLjMh+5XzcPruIDmgM4v2mce+7TQpxKYCteFDGGf893JvcdIt
 i14StQbNOLiQkKK/hD14TVWLb51Lhbd7S1pUAhU5uTbUnnMx5iY1mXJEd7+Mrh2dOd4YTseoa
 vUI4tpA8ilPBlO/BmxHN55IKYYSdK5QECoDqoIJDyddrLSzi5HNOzsL06JQquqG8zosDfxQI3
 nViJk23RRP5iwgU6QDrKzupXP/iAuuj3KkWAvJXgKLXFFhnXuHW8Erv3APeDGhQNSv4JV7fJs
 FiV6Kts+ZLka9biLf2k66odpMo6+Rxe0NyNKDUxXS5LimzGvXaGlYV5oa2ENiBftxL3vgVAbk
 M2oga3RxZG/lk4DuePVrNRMxLss0CMabkeGM4KDjr6vY5Oj4z6pVl3NZ2eqyK6Q6WJ+/gPPfT
 OEh7hPJrupBZ2G0eJTe+oo4J1IWtadj1v2AQQ+KCkBNdRmpn8YCUObVfnx1ePXHlKH+e9pm2t
 s7mQIq/Zkb6zcQNHsuR7vEunAC8xfrS4b/jhgoaFkXkrlQk0XOnxFQ2cjd7ZPotNy74QcPphF
 xzVteH2arkXCA1Z/gzUUl3IQzYnQjd9e7n/ia/7DJjmFAR39gndm3UpPOdrnrAHOEZB4ILRuN
 HLYLvUU/9r/Th7GefF8FCnUhF7y+JqW+1XyaovHwldB5nWdhlbxq5REgsrDhjaj5Z+WGO8mx1
 DLXOf7CJljmxYILBZe+nnuq7/4EG0rUEnK2XA8fQ4QeOn9SCZ+qGj+JnqOGbt51LI6lzAZz2p
 FVldcm0HJt1ZrkFotA3CD0gO+MS43lLlACeFLEaOJ7xU5Dv7IXkngr3xqO9B04iKg7KevruhK
 GmGsntzJ9gZWe7tRyw6IZmIc9sTBUEZDHhqYIW/izxti7BXtp5QGwt7xytaJ7HrpJ1wIURtoK
 X4MIVMSTaKbXYmbdej9MmBNVCWK4ku9hoAROSD6DugXSFIJ6qM966ej7B9lowXyKnC0W1QeZm
 zifsyIM1GBXEqu2TT8Ca4Y7ZUZCtMZxqnIaOaK40HGgh9aRGPrgw6txrtCDcJcgYMq7LLqrC1
 9261LB+NV5Plb7sLLd2kjTyZJfMAV4bpYKm+27cWeWVl99OhSldQYDobGpAs5/bZlLDdS+BlG
 5/MKKHhHem8MqbS9h
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Eliminate the magic numbers, add vender infoframe size macro
> like other hdmi modules.

How do you think about a wording variant like the following?

   Subject:
   [PATCH v2] video/hdmi: Use =E2=80=9CHDMI_VENDOR_INFOFRAME_SIZE=E2=80=9D=
 in hdmi_vendor_infoframe_init()

   Change description:
   Adjust the usage of a =E2=80=9Cmagic=E2=80=9D number here by adding a m=
acro for
   the vendor info frame size (similar to other video modules).


Regards,
Markus
