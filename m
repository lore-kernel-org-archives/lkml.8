Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE48AC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE4F2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKvCh9At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgCZKUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:20:30 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38330 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCZKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:20:29 -0400
Received: by mail-qv1-f68.google.com with SMTP id p60so2604271qva.5;
        Thu, 26 Mar 2020 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AO1+kLNJMIFIpXSKsYT0LBsgxe58i/XAiEepkW6Sx0w=;
        b=BKvCh9AtaNfMMgTpt8Ez8PpkWAbj+U1VYKEGO+xJv1hXyZpwI4CjCDIbn34nnAdyOu
         85+SRsrfQucAUDlfxWxh61QuUYgO37Lb4DPwFtzPIZCJ0WXfZB7uYPPVL5uiAisMPevw
         GUu8fgd8g/1YlVrUrflHRoSGY+GA48lIn53vkKW5VVvSOZiSF5b5vQXkCC55FEazKl7a
         ex05FJ8T/nB/671yzEc78WAggpP/mjb4OETS8Mas+NbOYQaURL3Q3a7fVMs4wYQKxw6M
         q165BbKQOQR2DfA7CxyqM0IywlBOqQQt7HkyC/O9eR2qKBt393YyiZqGjmieJk80a7oa
         puJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AO1+kLNJMIFIpXSKsYT0LBsgxe58i/XAiEepkW6Sx0w=;
        b=UUTmva0xL7IlxRaOIHds7UgPGEgAuAEn8dKNoK6legkTyrV2oL8bF9GwuVhRBHde6D
         7ulf6tvBA1E+D9TE3E3691cJUnqad7eo3iM/BM6gjzoaJp2mNr79RZ4kt8qS+Y4J58Qw
         hI0S1zfsHLhft+vf+6w6vDDYTIiWbWxxH6ZF/+MndaA865O5Vtb+sdf795DaGbcmnE5W
         zeLWDgu1WBu5juWEONifX59FsKhFv8juR3hggRB6rxU7eIXGcNR8sCLgvLzhHUQaW5Pw
         zzOYT+2eEQApHrjOxCzTZUK16N5ichYc6UEPkKY74IiyCXg3LWxLbZnF0RGAySp/oIeB
         apow==
X-Gm-Message-State: ANhLgQ02oGWTJJaQ5VvZzkQ+pXJvA7oEvvf0N/8X8ebMTcX5drOwyqWP
        V0UGnXKuRMwgBqeOcHTDp0ITk/rK
X-Google-Smtp-Source: ADFU+vuscYuwV4iW9IijORpo2EgGQA4Xn/uP+p6DYZt5WvK4rhT1BDT8FxqY47IRf0X5w+eGJZZWtg==
X-Received: by 2002:a05:6214:72f:: with SMTP id c15mr7069507qvz.3.1585218028218;
        Thu, 26 Mar 2020 03:20:28 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id d24sm1096242qkl.8.2020.03.26.03.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 03:20:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] of: some unittest overlays not untracked
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
References: <1585187131-21642-1-git-send-email-frowand.list@gmail.com>
 <1585187131-21642-3-git-send-email-frowand.list@gmail.com>
 <CAMuHMdXnQ2Tcbac4OoWuSDO9KK0zMLt7ZbMdF79sCj-Yf78Bgg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ddde9dca-6333-ba16-e97d-299fde06aaab@gmail.com>
Date:   Thu, 26 Mar 2020 05:20:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXnQ2Tcbac4OoWuSDO9KK0zMLt7ZbMdF79sCj-Yf78Bgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 3:21 AM, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Thu, Mar 26, 2020 at 2:47 AM <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> kernel test robot reported "WARNING: held lock freed!" triggered by
>> unittest_gpio_remove(), which should not have been called because
>> the related gpio overlay was not tracked.  Another overlay that
>> was tracked had previously used the same id as the gpio overlay
>> but had not been untracked when the overlay was removed.  Thus the
>> clean up function of_unittest_destroy_tracked_overlays() incorrectly
>> attempted to remove the reused overlay id.
>>
>> Patch contents:
>>
>>   - Create tracking related helper functions
>>   - Change BUG() to WARN_ON() for overlay id related issues
>>   - Add some additional error checking for valid overlay id values
>>   - Add the missing overlay untrack
>>   - update comment on expectation that overlay ids are assigned in
>>     sequence
>>
>> Fixes: 492a22aceb75 ("of: unittest: overlay: Keep track of created overlays")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> Looks good to me, so:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Still, a few suggestions for future improvement below...
> 
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1689,19 +1689,27 @@ static const char *overlay_name_from_nr(int nr)
>>
>>  static const char *bus_path = "/testcase-data/overlay-node/test-bus";
>>
>> -/* it is guaranteed that overlay ids are assigned in sequence */
>> +/* FIXME: it is NOT guaranteed that overlay ids are assigned in sequence */
>> +
>>  #define MAX_UNITTEST_OVERLAYS  256
>>  static unsigned long overlay_id_bits[BITS_TO_LONGS(MAX_UNITTEST_OVERLAYS)];
> 
> Obviously this should have used DECLARE_BITMAP() ;-)
> 
>>  static int overlay_first_id = -1;
>>
>> +static long of_unittest_overlay_tracked(int id)
>> +{
>> +       if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
>> +               return 0;
> 
> Do we need all these checks on id? Can this really happen?
> I guess doing it once in of_unittest_track_overlay(), and aborting all
> of_unittests if it triggers should be sufficient?

Yes, that would be a better location to validate the id.  All of these
checks will go away when I get rid of the bitmap (see below).

> 
>> +       return overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id);
> 
> No need for BIT_{WORD,MASK}() calculations if you would use test_bit().

I was trying to not get too carried away with cleaning up the tracking
code data structure in this patch.  In general, I would say that using
a bitmap is an over optimization given the very small number of overlays
that are tracked.  Long term I want to change it to a simpler form.

> 
>> +}
>> +
>>  static void of_unittest_track_overlay(int id)
>>  {
>>         if (overlay_first_id < 0)
>>                 overlay_first_id = id;
>>         id -= overlay_first_id;
>>
>> -       /* we shouldn't need that many */
>> -       BUG_ON(id >= MAX_UNITTEST_OVERLAYS);
>> +       if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
>> +               return;
>>         overlay_id_bits[BIT_WORD(id)] |= BIT_MASK(id);
> 
> set_bit()
> 
>>  }
>>
>> @@ -1710,7 +1718,8 @@ static void of_unittest_untrack_overlay(int id)
>>         if (overlay_first_id < 0)
>>                 return;
>>         id -= overlay_first_id;
>> -       BUG_ON(id >= MAX_UNITTEST_OVERLAYS);
>> +       if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
>> +               return;
>>         overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
> 
> clear_bit()
> 
>>  }
>>
>> @@ -1726,7 +1735,7 @@ static void of_unittest_destroy_tracked_overlays(void)
>>                 defers = 0;
>>                 /* remove in reverse order */
> 
> If it is not guaranteed that overlay ids are assigned in sequence, the
> reverse order is not really needed, so you could replace the bitmap and
> your own tracking mechanism by DEFINE_IDR() and idr_for_each()?
> And as IDRs are flexible, MAX_UNITTEST_OVERLAYS and all checks
> could be removed, too.

The id is actually allocted in the drivers/of/overlay.c via idr.

Thanks for the thougthful review.

-Frank

> 
>>                 for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
>> -                       if (!(overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id)))
>> +                       if (!of_unittest_overlay_tracked(id))
>>                                 continue;
>>
>>                         ovcs_id = id + overlay_first_id;
>> @@ -1743,7 +1752,7 @@ static void of_unittest_destroy_tracked_overlays(void)
>>                                 continue;
>>                         }
>>
>> -                       overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
>> +                       of_unittest_untrack_overlay(id);
>>                 }
>>         } while (defers > 0);
>>  }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

