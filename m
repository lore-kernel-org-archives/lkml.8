Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37CCC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F1E20753
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYGEhZM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgCPT2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:28:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40755 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbgCPT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:28:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so15061264lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9W++nvTHbfXeoIcDZohOBZWZ4LKN9eFr+StdFejbfcQ=;
        b=YYGEhZM7PPavYrG7MqPMpq5f7+jG7H/yxC5PSXo/ntzCb32eA6x3sviAXL5LkLPADt
         HsJ0OW7yc8ZaY/BMWvM3uvCuRq0WYc5+11RIrVcbAuWv3YlGQcKZ9EExZuZbCBm8FfYF
         QbF9aV/ZUs5MeYh9+WzvYlXU4izRU4Nfij9AgZ4JqvLKn2thuw35T9IhZ7apkWnLPWWr
         xv5Z0YjGrNlMcgBgIIvEIhIEg71Z4PpMPsLA/j30sUqBzjqGzM+gBW60ivkHZxwFFNeQ
         EoP7T24Gh8veA5TnxfeF9dZup5lv6L61gYWY2Z+r+JTJTzR5B9nEdTKiuxJrRhATQY6h
         R91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9W++nvTHbfXeoIcDZohOBZWZ4LKN9eFr+StdFejbfcQ=;
        b=KtrAdLuedo5p2vcZr6rMSr8+1Czo5mdBSEi3QMDnxi+cRXs+EMB4Cblg7j3AYdkUMj
         wuAt8x+eQsTo4Z3HtoWqKsIkEXsg70Li9gB/moUXP+3OXFTT7NaaP7aX1CUJUfbn82ap
         3XKLAB/1p2ALwIT+GJuZaMHx8pR884veeiFC3TWMbqU88TO1fdEKN31o3CU53Y3davFl
         aHNPH0Aq/vhxBHsV+l0CUs3RwJwpyjfHWM+XbkMLPvW1DA11s+sxkoNmdttSnYouoLk9
         M7ytMu4lLFjOl9/4Pz2N2v6n2G33Xl2sdMkHDkmZnLUi7CKwEaWt4CAaMqYTnyhT0vw4
         bIDQ==
X-Gm-Message-State: ANhLgQ2PbCjwHW2o2hJLG0jFKLFJD1PUVEZuxPy/AP016Q4bdsV5ZysY
        rqNj83qIho7K6JnVvmsfEvdonNcIDV2ZvLVi1+7i
X-Google-Smtp-Source: ADFU+vuK3Glg35VFHYG66rljp/O8A8T7rbFwvJ8CVf9D6xtbfhbcuuYaoE3SLZuTyADw8oBNT8YpaYMIqKTqWs+iAig=
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr576598lfi.57.1584386902991;
 Mon, 16 Mar 2020 12:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
 <20200302235044.59163-1-zzyiwei@google.com> <20200303090703.32b2ad68@gandalf.local.home>
 <20200303141505.GA3405@kroah.com> <20200303093104.260b1946@gandalf.local.home>
 <20200303155639.GA437469@kroah.com> <CAKT=dDnT_d-C2jfcgD+OFvJ=vkqxvQDmg3nAErvs9tXS6iifpw@mail.gmail.com>
 <20200316140544.42e3f383@gandalf.local.home>
In-Reply-To: <20200316140544.42e3f383@gandalf.local.home>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Mon, 16 Mar 2020 12:28:10 -0700
Message-ID: <CAKT=dD=g1aK6At4hCyjDNc_S1hR8TUngR7Sm13kgP+tNr4WOmA@mail.gmail.com>
Subject: Re: [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com,
        elder@kernel.org, federico.vaga@cern.ch, tony.luck@intel.com,
        vilhelm.gray@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        paul.walmsley@sifive.com, Bjorn Helgaas <bhelgaas@google.com>,
        Dariusz Marcinkiewicz <darekm@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:05 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 13 Mar 2020 15:59:37 -0700
> Yiwei Zhang <zzyiwei@google.com> wrote:
>
> > Hi guys, thanks for all the help throughout this. After struggling a
> > while, I failed to figure out when the next merge window is. Could you
> > help point me to the release calendar or something?  Thanks again!
>
> I have this queued in my local tree. I'm currently having some issues with
> my testing (there appears to be an unrelated bug to my code keeping it from
> passing). But you should see this patch fly by when I add it to my
> linux-next queue.
>
> -- Steve

Got it. Awesome, thanks Steve!
