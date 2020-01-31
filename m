Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CFC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399C12063A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAnnKWp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgAaEdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:33:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40877 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgAaEdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 23:33:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so2785108pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 20:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5YBPz1R1Tq8ogjk4q4yHg3F3OHJSAN1Ceopqmh7+8Ms=;
        b=YAnnKWp5jcufgnbgPcv7AKk75oBjxglaEg8N0nURW7KbIivjyueLQAlm+afiAEsTht
         caqFkHkcyvRXrfBNPprCTG+99uObZzuJBYBbTgFmc4sJrU/pSxgqtzEE14G82M9gK571
         aAzjd1LChFuhfpOBh/eJSX3ICmG9xLLGjb924fwTPG+O8qzY6s/NrZ8tDPYQsSzpGOWE
         +LZy5oJGpqYPGfyrxxSxkQtVFY+EwLgAhswTruf1iUqO2eOwt0bveKVSEhILIGyA1iil
         RYRSvuaqA+HZVgtyxbVZPZ5PlE3wNr+AFrw57j1fystiU4DG+cP6lpqeeWnd3lV6QPo3
         CYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5YBPz1R1Tq8ogjk4q4yHg3F3OHJSAN1Ceopqmh7+8Ms=;
        b=jns3tsNb7apfWJNKZhq+O5IhL3S79Q9enVJWX/FGUUx5uu6ts9RoSGUESt1oNWw9um
         Y6IU7hjPJTaLxKOK3/nJeUWu655F/iYiQ6hvq9whMUk56cWdGiMk/Ib2rJqoe1Naf4jP
         g7rDgviX2ZVxrNiCw2T8ZiavafBLNUVC83iaRO4u8EE6TObxhpBqiplOIZqF/q/hWQtx
         iwQD/s2tATJZunvOUo16Zrn4pJHC9eo5Bsubd2InB34XvDUdXj90VQ41PclDRhBcQgH5
         3BeFlDXHu8TosJFDPjOl+l0mRH4XgqW/1pF5nf+MRgTeeRMsy5zi2Ni6S1It8in2FM9h
         Drng==
X-Gm-Message-State: APjAAAUcPTkBmAt477Cx32raAIjcXeMivgl8y2FQE1UdXdVMFYma6FtG
        5KfBlaV/rx46sEq3TTJnczK3IA==
X-Google-Smtp-Source: APXvYqwEN17hrZK69xPBYl4VAlSoCipA5jd/df38BHlKebya8QekoVxPecktD08Jwc9BQOd4P5p+ag==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr8470354pfh.124.1580445191433;
        Thu, 30 Jan 2020 20:33:11 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id w18sm3860635pfq.167.2020.01.30.20.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 20:33:10 -0800 (PST)
Date:   Fri, 31 Jan 2020 10:03:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, arnd@arndb.de,
        jassisinghbrar@gmail.com, cristian.marussi@arm.com,
        peng.fan@nxp.com, Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200131043308.gxcekh2tioydurq7@vireshk-i7>
References: <f170b33989b426ac095952634fcd1bf45b86a7a3.1580208329.git.viresh.kumar@linaro.org>
 <20200128173524.GB36496@bogus>
 <b970542b-0c05-5401-46be-5f585bdafb09@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b970542b-0c05-5401-46be-5f585bdafb09@opensynergy.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-01-20, 12:58, Peter Hilber wrote:
> Maybe the mark_txdone, fetch_response, and poll_done ops should also get
> a `u32 msg_hdr' parameter? I thought it could be required in case of
> concurrent xfers, or maybe I don't understand the imposed concurrency
> limitations properly.

I would like to avoid doing that unless we have some upstreamed
transport which is going to need it. The parameter won't be used by
mailbox.c for now and so better add it later only.

-- 
viresh
