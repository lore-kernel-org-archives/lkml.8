Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E893D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jonmasters-org.20150623.gappssmtp.com header.i=@jonmasters-org.20150623.gappssmtp.com header.b="XbMDk80t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgDXGlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbgDXGlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:41:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D729C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:41:49 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t8so4192898qvw.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dw634XdyImgBtxBGiKE6aOOF3ij0GTDJAHDLmmt5LWA=;
        b=XbMDk80twGVmgH7VAv4fo1NBup5wcjQC9l4DDzhD7aB/wd4FSW/leAjuRJmSMv5+fm
         Pf0nli2XpbKq4zZVB5KDSY5KuBhWPzagfLa3LUeSVdKLQrtpPKgc0DybawmrKwIOXHRL
         1U6Qg2DfJ3qh5blhXHQhF+dd0R7q06eWp+m4TMfDXPXMt6O7P34d5KizON3EAeFafcN9
         dzWwKJWcg3DoL9n5kqna+c2vPLYZgAi3fuxrqFJh2bpjUy4SJ2I+1T3yA5DkFux1rN9i
         QCC8HSxatNmvbZ66lO3iSIh89tT3AGQgNpbF4nWnqsPZVqNtA8o+EqbWC/Waya4sN+EJ
         5JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dw634XdyImgBtxBGiKE6aOOF3ij0GTDJAHDLmmt5LWA=;
        b=ubkSpsAr5IA6083G0zAURZK8dp0dcQLiKOwV9KuGvrZjc+vra1W2ib14JbCaeUGdOI
         jQtDWQMf/8huPj+6aSAS3wrxmqYPIOO3lNokJAkFXYM61ySa70WOTe3+nZrj8R3QF1L2
         0fy0VVH098iye/9KXoLDtePtKuO8UysCmaMydlrbCAucHW2F4g15/ks2Ar1pjVwqHbVi
         TMHFgbNe/CJ1MY4XXAUdpgVvt1cEdnjs7Sj9Y8yzYghAQvsvu5CN6m/8KhiyIjvY1hkF
         O71D3HPyFw32Ydtr129LpP69T6aGua/Ue9oTrTSi7JR98uSDf8JDrItHQ4GFPBR15vb4
         Pw1A==
X-Gm-Message-State: AGi0PuZj5PIs/PyqruxB5kkIuM4+cvxH1OhOz2PxTxwO4Ur1+hSXhFUi
        8kAD2JGZLkRch+R+78w3Z3MYS2N4268=
X-Google-Smtp-Source: APiQypL/sVIxGCPChbkFMeL7MpTIjm0PFfEfGZJNdnHvQc46o/m2udafOY4Ej2MAPzEXcihSk0e1Bg==
X-Received: by 2002:a05:6214:150f:: with SMTP id e15mr7528697qvy.18.1587710508495;
        Thu, 23 Apr 2020 23:41:48 -0700 (PDT)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id o201sm3193720qke.31.2020.04.23.23.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 23:41:47 -0700 (PDT)
Subject: Re: [PATCH tip/core/rcu 2/6] Documentation/memory-barriers.txt:
 ACCESS_ONCE() provides cache coherence
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1392672413-5114-2-git-send-email-paulmck () linux ! vnet ! ibm !
 com>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <f3cdec26-480e-d2e0-3e54-4b0536831fcd@jonmasters.org>
Date:   Thu, 23 Apr 2020 23:36:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1392672413-5114-2-git-send-email-paulmck () linux ! vnet ! ibm !
 com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2/17/14 4:26 PM, Paul E. McKenney wrote:

> The ACCESS_ONCE() primitive provides cache coherence, but the
> documentation does not clearly state this.  This commit therefore upgrades
> the documentation.

<snip>

> +     In short, ACCESS_ONCE() provides "cache coherence" for accesses from
> +     multiple CPUs to a single variable.

(ACCESS_ONCE is now READ_ONCE/WRITE_ONCE but the above added the 
original language around cache coherence)

I would argue that we might want to avoid describing it in this manner. 
The hardware provides cache coherency in order to keep a single memory 
location coherent between multiple observers. These kernel macros only 
tell the compiler to perform the load once. They take advantage of the 
properties of coherence in the presence of multiple observers.

Jon.

-- 
Computer Architect
