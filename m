Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MENTIONS_GIT_HOSTING,PDS_HP_HELO_NORDNS,RDNS_NONE,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40026 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgCJWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:03:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id e26so3113372wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:03:19 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>,
        "open list\:ARM\/Amlogic Meson..."
        <linux-amlogic@lists.infradead.org>, SoC Team <soc@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list\:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
In-Reply-To: <CAL_JsqJAxfL_Q3HYHk_8VeefdXnhYT7kcPe3F5Gzk1Vfj+xtww@mail.gmail.com>
References: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com> <7hsgiqra5x.fsf@baylibre.com> <CAL_JsqJAxfL_Q3HYHk_8VeefdXnhYT7kcPe3F5Gzk1Vfj+xtww@mail.gmail.com>
Date: Tue, 10 Mar 2020 15:03:15 -0700
Message-ID: <7h36afn9zw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200310220315.xvD08fsSOARkF9DsuGnbadohp6kj581dl1BE3KafdDo@z>

Rob Herring <robh+dt@kernel.org> writes:

> On Mon, Mar 2, 2020 at 10:31 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Hi Jianxin,
>>
>> Jianxin Pan <jianxin.pan@amlogic.com> writes:
>>
>> > Missing ';' in the end of secure-monitor example node.
>> >
>> > Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
>> > Reported-by: Rob Herring <robh+dt@kernel.org>
>> > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> > ---
>> >  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> > index af32209..bc4e037 100644
>> > --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> > +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> > @@ -36,5 +36,5 @@ examples:
>> >              compatible = "amlogic,meson-a1-pwrc";
>> >              #power-domain-cells = <1>;
>> >          };
>> > -    }
>> > +    };
>>
>> Thanks for the fix.  Queued for v5.7.
>>
>> @Arnd, @Olof: you can ignore this one.  I requested Jianxin to send to
>> you thinking this was a fix for something you already queued, but it's
>> not.  I'll handle it.
>
> Someone has what needs fixing queued in linux-next, but this fix is
> still not there. Somehow it seems like features show up in linux-next
> faster than fixes for SoC tree...

The fix (this patch) is queued in my 'for-next' branch which I pushed
yesterday.  I guess it missed next-20200310 but should be in tomorrow.

Kevin


[1] https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/log/?h=for-next

