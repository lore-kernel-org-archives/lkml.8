Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5B820838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vs+Ds/Lb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wDx8T36Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHZJlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgHZJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:41:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2DDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:41:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598434896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5T6JrWkd1tVkRpZewBe6NAmILES/5wwAPylURy3cHTs=;
        b=vs+Ds/LbD0tTKUu7T/oAp0naRYHaICf4Uzked2Z7DlqMXJfCSN3dedfrgqzdFJfVooN7MH
        fdVNfdI99UDRb4kCm0JgWh8hofy8RqHby4n7Fb/szzfOm/oO3eAfAVYsju1UpkeFOPd0hv
        UF0/q+9Lghs6MsqdUuvTMxNA4pHhx3kT0QR8A6S2JQ5k+VBKtoYomwghPKEKoK++SPU5TX
        zuPuFsN0U9WdgvtWdcuMvlmRWdiMU4mabvT12RIiwxuw7RnzsjbpZyF2Jpwche+Kt1bNsG
        7Mz3bEM/D0G9xTqOC0YLx0UnFpLsghkWMstQjNHSvO1u5uOwqvinAYdpqqoHsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598434896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5T6JrWkd1tVkRpZewBe6NAmILES/5wwAPylURy3cHTs=;
        b=wDx8T36QjzCa/Lb0ilvtOsRnZ2SqWyJ+O94RgCcrG6oJs6bx4Coz4gPpuM7jaHRiaHOTbH
        ARvjcQCKmO/4uCBA==
To:     "Zhang\, Qiang" <Qiang.Zhang@windriver.com>,
        Waiman Long <longman@redhat.com>,
        "elver\@google.com" <elver@google.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06?= [PATCH] debugobjects: install
 cpu hotplug callback
In-Reply-To: <BYAPR11MB2632ABDD5A8334F74B4F539AFF540@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200820032453.5222-1-qiang.zhang@windriver.com> <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com> <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com> <87pn7ewae6.fsf@nanos.tec.linutronix.de> <BYAPR11MB2632ABDD5A8334F74B4F539AFF540@BYAPR11MB2632.namprd11.prod.outlook.com>
Date:   Wed, 26 Aug 2020 11:41:36 +0200
Message-ID: <874kopwxpr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26 2020 at 08:34, Qiang Zhang wrote:

> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: linux-kernel-owner@vger.kernel.org <linux-ke=
rnel-owner@vger.kernel.org> =E4=BB=A3=E8=A1=A8 Thomas Gleixner <tglx@linutr=
onix.de>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B48=E6=9C=8826=E6=97=A5 =
7:53
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Waiman Long; Zhang, Qiang; elver@google.com
> =E6=8A=84=E9=80=81: linux-kernel@vger.kernel.org; akpm@linux-foundation.o=
rg
> =E4=B8=BB=E9=A2=98: Re: =E5=9B=9E=E5=A4=8D: [PATCH] debugobjects: install=
 cpu hotplug callback

Can you please fix your mail client not to copy the headers into the
mail body? The headers are already in the mail itself.

> On Tue, Aug 25 2020 at 18:26, Waiman Long wrote:

Something like this is completely sufficient.

>>That's a really good question nevertheless. The only case where this
>>ever matters is physical hotplug. All other CPU hotplug stuff is
>>temporarily or in case of a late (post boottime) SMT disable it's going
>>to be a handful of free objects on that pool. As debugobjects is as the
>>name says a debug facility the benefit is questionable unless there is a
>>good reason to do so.
>
>  I don't know there may not be too many objects in the percpu pool,
>  but that doesn't mean they no need to be free, a CPU may never be
>  online after it is offline. some objects in percpu pool is never
>  free.

And this matters because? Because your fully debug enabled kernel will
have an uptime of years after disabling the CPU?

That said, I'm not opposed against this patch, but

     'we should free objects'

is not a convincing technical argument for doing this. If we want to
have that then please add proper technical arguments to the changelog.

Thanks,

        tglx

