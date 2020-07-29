Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A597C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688FE20838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgG2ITG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:19:06 -0400
Received: from nsfocus.com ([221.122.62.131]:47378 "HELO nsfocus.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S1727044AbgG2ITF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:19:05 -0400
Received: (qmail 8939 invoked from network); 29 Jul 2020 08:17:41 -0000
Received: from unknown (HELO ?192.168.7.10?) (221.122.62.131)
  by nsfocus.com with SMTP; 29 Jul 2020 08:17:41 -0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
To:     Jiri Slaby <jirislaby@kernel.org>, b.zolnierkie@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>, Solar Designer <solar@openwall.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        Security Officers <security@kernel.org>,
        linux-distros@vs.openwall.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <c1f267aa-dfb3-91fa-3111-30c1676f1a91@kernel.org>
From:   =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
Autocrypt: addr=zhangyunhai@nsfocus.com; keydata=
 xsFNBFXf+bQBEADB+vY6HC3E/hdYvhlVSXWcxXNxk2yHU+P2Rz0dWB5LibtRCm8SAdwFOBRr
 iyws5OnV1T6j/HnXPR7ENtYbpL+fIcAv5o7jJyEl4cosbpDl0H88Tj/Py0YYEOJg0nm1F0LW
 0NlIRG3OSSJQ8UHsCzFPqHQnUJaymfwoyYgIexxkG4Oi+cXVHVnbV3Qafe3H+siB29dfPFuf
 iZzPhIDnE2K/MF8/RmeB7CTc2Y4lc1CCbKiJsLYMx4CBrQ2qkGyC3XRorMfBRvhglmIY51Lx
 nHrd5s2vS13YbeeOyU9l54SjipL6XQRdSo/j/xTJBhT7y/c22E52AtsqeuH7gJU7MQnkS+cp
 FN2b2EcQdWlbUKIm3Tlbs0Y2vjV2cpNNDMc8uVGwddVeNdMjq9tXFkgLQww8SAEs+g15ai5v
 /LiGy/4NJodl9wSiamsgjBSn8AuFJTazy99k6ug+wLYp0kzD/sB0Otg/UbR7yTS4xjwhyk09
 WOk3/wLptYujh/0BBWpaCXsLW117PGFz/iSu7QAJhOdlNaaJYxOUDHB4dZPEpRSE6tGGYpZ6
 AyHkgprFD/lpAluSsSbskjAgPCqdzrU6kZItcc1uu8QIh3Vd1j0iFo8sBLSrg0WXyE2N6mgg
 MZxkMtQLxy3XkQ7iofoeqgvujufN3pyfBeBzCjRi30W72IOsdwARAQABzSZaaGFuZyBZdW5o
 YWkgPHpoYW5neXVuaGFpQG5zZm9jdXMuY29tPsLBeQQTAQgAIwUCVd/5tAIbAwcLCQgHAwIB
 BhUIAgkKCwQWAgMBAh4BAheAAAoJEP4mMEaS5e9PRhsQAJsAmfByeSyMLVFKqVV+A13ESSGn
 zQW7SzVdcN++WgpGpSUpaQavCRKhzV6InJTUEVpPOphV3v/wFJL3cVYSfm1zxdjd63E116Ow
 utq4PcavcPkRch9scTrHKKodxbrSwepD50iCqOiQZpVd+bPy14oT/naKCnif58H/9+ZEwgZ3
 EQh79MBvzN29uzIc1e4sOFwCS+Ew3OrzLZWaNRPLnonsOAkTVEBcMXOxqx+XPexfKHHc4Ukf
 omKJUO/Q8a7F1SlLa0jcY1Yq5AAAYFJ1DgwPqMVRF69+mE9C7Q9FBKXM8ShGF9VhYjefmBq1
 UczE/idMAAlUvOVZ/eMeicn1QirKCISSw5yIkLhv8np+1ZBJo8oroEP87Z4JIStGa6sX7E3H
 s7/3lo8M8oEDl4IyqbXkV/i/pXEiWCd2fVrq+2S45xPOJZgpJ9tKuRxcGYHku9U7LKVG3kni
 YV/DqOGeCkoxv8mk9C8/CSfJaIrOwqLr86NFnNkL+lXaaPjvvKvpQ3ijIImtDI7TbK9n8Gzd
 8V6A7Oy0EqYtfjSp1yZkeF3viYWFyDGyiSuL3NhC0jszTWxQXFIvgUgjEDcYiaMVF1oBh7iA
 MAuzUGjLd0cj4rjokSmYT2JrxQzx5PeUtIh7JXl1Zj0uBxg1s9y9OZ8mmYBwqZ/UdeYtnThe
 26MoIZ6+zsFNBFXf+bQBEADhCv4euKnMwXnMePjAkToO68fjA6qg1wNDzezo+xQcO01k23us
 bTdvtkrAEhRkA/fy+M3q6yaP+STObQbF41Er0Bfmwtaxt8yXG5OmHNTpvBzM/aW5I9XNPCUj
 NcOZDGadoPMmo50S0krzA/i6ah/KHnsaB6ZhWRQxXITKs9xxswuNuRIQ7u1VeQlmADh8mfJ8
 YhFHCioeMSu7HNr+hI+jrZyUE1gPmSmLFnFZ96ONonN5pIJkGa0Lmdshn7nTsiu//QzPQasa
 hFm4REKTauIFMchDmjkzhWCEHTheaYqzfqFRnsiQi1iOqQ7i+Mnt6YjLaGJe1ZfKQaNTJsvL
 yInE3Ienoh3gVy4pEgC5wCbuBt7cZ9YYgjTN5JBGKZxahUd4kfto2L0ya5pLcjF1YVtYLaUI
 xJ28h01tVU4zmiBMVmhCMS++fO3RdGwYSd49jOt0KKi26rukvuKgb16yjD6nNajlJpUsVOBP
 n7165+7GKM6P2uFps2Qn39FxU29bGTxwHGjIYP7oc22wlh69SZ/EXDup4OhjifZnAyyMsHYq
 DjLLT6Kjqvh0pDs/ay1+Hs8Qq2z9Bl2/Y4dqLmhtRHzPC3LXwn6OXYoiiojjO+z+aJ0AfdE1
 s0iDw1oQhKCQsH6ReiLd3R1cmOovotyQREXDml136OPwEnWiL2sNH6dE/wARAQABwsFfBBgB
 CAAJBQJV3/m0AhsMAAoJEP4mMEaS5e9PzywP/jdR9cn0s2PNa0fQEPo7Ai6v6qy2dHp0lopa
 8k/KoIpZEhgnFgy3aVL+vL+9AuaZfSdm3gwW4t4V5GbR5HilQ6Nfp0sJVpE8F/JOF1P9SLSy
 fIsna0tcqE79/isyF+ockZwVK5rgwJHqEIzr50TOKob2yY4AF0ZFQUSrpU/AmE9OK1EH5d88
 gIki0kOYQwteL8hLTjkRlecjiBSljA9V4VZVwpXyCHUDO3sCxJQYMaiSTjGEztswoAyUy0Q+
 xnpzelyw670W/y9DAgafdaN5MJldyAapUOv8yIRSlQ5M2f3ZFyjJOAozNXfqXiuHkKoXgsbW
 Sfh/o9HfPE5y8NCPJY1IoHRr1pUklwVNIwM77xpQxBFhBPNUbL43igdqRf6hApk4aJ/jT7pF
 wPKclsAKfZTkqYOksT1Qh0FURhr8S6xUe3aV9omGXIOLGMIbpHuZSbP0akdHA0nzUY6HYbN1
 0T3X0bi33lOUefj2uAnhuPeReyAP02CjvkNJVfBRho3h/D56ofuPdvfAetT46d6y+tQVdoka
 5tO7oLXD/f5GPuDoYSjfOiIlU4d/tIDUdyXXfml0Ez8DZk0c+3z61TNXRDV1tzXKmC1oV+6m
 Ql46hjmfjnRfvq72kL55kj+YzWjlM9h98+4vqknUPPYIq+lUz4hO7I3b64i5sPkBWtN7DLkm
Message-ID: <c5a73038-f441-602b-584b-3d84622b1fb1@nsfocus.com>
Date:   Wed, 29 Jul 2020 16:19:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c1f267aa-dfb3-91fa-3111-30c1676f1a91@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/29 16:11, Jiri Slaby wrote:
> But the loop checks for the overflow:
>   if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
>         vgacon_scrollback_cur->tail = 0;
> 
> So the first 2 iterations would write to the end of the buffer and this
> 3rd one should have zeroed ->tail.

In the 2nd  iteration before the check:
vgacon_scrollback_cur->tail is 65360 which is still less then
vgacon_scrollback_cur->size(65440), so the ->tail won't be zeroed.

Then it gose to the 3rd  iteration, overflow occurs.

Regards,
Yunhai Zhang / NSFOCUS Security Team




