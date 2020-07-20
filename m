Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADEDC43457
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E31206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262844;
	bh=smOhhzPw6keHJLqZTbY3QNqrcFt6pebab94xYAwlZag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IwJFx4ka8pO9xdcJFJ+GKHVhBl5GNyk5ON0TN9QGv2njvDiwLPKqEt7k0DfXWeM7M
	 BqQ8RyGBNHvObFBbdLRsRlbqvekrbBTD2DxcwzbCQPs8ARmaKsk52zlWrTeGdPB7MJ
	 qiaM+N7RigLTA8LRWYAUTmeMUi+j/5ryY+6IsfIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbgGTQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:34:03 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38462 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbgGTQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:34:00 -0400
Received: by mail-wm1-f54.google.com with SMTP id f18so146320wml.3;
        Mon, 20 Jul 2020 09:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vsumXDSjRCB3mjTpA+ep77yxk0IlkkZV6qgRHqWpdCo=;
        b=lsqMeRJklChZBg1IlCoEfDJCPnGasGqcJXCtsskjtIRB8df+zICfx+/0We6BhSvZMq
         gmvxKnOEYZis4+BRnnVd3yHQfLTR0nY201n6S8c0ekOx8UgEwNh0JAalCLLhBq1RNRRm
         aUIHdi2WTmXtDj3pDtVHz3D/A+GcCMBRDJl2CHogIGlnanugCS3qyGCW2vu5o7PFcMk1
         JehJ92HxO+F7iopgul+7DuPYMI1b0GRt4TWgbrxGTWBTJFgC5Z6ErVon6dytXDXJ4/+S
         oNoZ3IVP6vRxmDn6NbCxAwBHLMwJ9VNHOaQNMZQ6I2OEkY5M/krpvU9IGoMrXoM43Le8
         4c/w==
X-Gm-Message-State: AOAM532Y6OwaZHkpY2cXE4z6AKZ1nMSkD8AOMEUsrw3lrxNOAQK9fbSa
        WMYvZiBTeIpZHSWWwEI8MqE=
X-Google-Smtp-Source: ABdhPJyBCfJt5mnYmvs0N2dm/zSvnpr7Pn7iHFOH6pzm91E8hNpV4jHXVySktCXThjCyz+o8Wxbjnw==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr170978wme.91.1595262837466;
        Mon, 20 Jul 2020 09:33:57 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id f9sm34272539wru.47.2020.07.20.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 09:33:56 -0700 (PDT)
Date:   Mon, 20 Jul 2020 18:33:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200720163355.GA4061@dhcp22.suse.cz>
References: <20200720083956.GA4074@dhcp22.suse.cz>
 <20200720135857.GB1228057@rowland.harvard.edu>
 <20200720143213.GJ4074@dhcp22.suse.cz>
 <20200720151255.GE1228057@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720151255.GE1228057@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-07-20 11:12:55, Alan Stern wrote:
[...]
> 	sudo echo 'module usbcore =p' >/debug/dynamic_debug/control
> 
> Then wait long enough for some interesting messages to appear in the 
> kernel log (it should only take a few seconds if the worker thread is as 
> busy as you say) and collect the output from the dmesg command.
> 
> To turn dynamic debugging back off when you're finished, use the same 
> command with "=p" changed to "-p".

[   95.395815] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.395824] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.395838] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.396016] hub 2-0:1.0: hub_suspend
[   95.396023] usb usb2: bus auto-suspend, wakeup 1
[   95.396029] usb usb2: bus suspend fail, err -16
[   95.396030] hub 2-0:1.0: hub_resume
[   95.396094] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.396160] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.396166] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.396259] hub 2-0:1.0: hub_suspend
[   95.396300] usb usb2: bus auto-suspend, wakeup 1
[   95.396321] usb usb2: bus suspend fail, err -16
[   95.396332] hub 2-0:1.0: hub_resume
[   95.396436] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.396443] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.396449] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.396582] hub 2-0:1.0: hub_suspend
[   95.396587] usb usb2: bus auto-suspend, wakeup 1
[   95.396594] usb usb2: bus suspend fail, err -16
[   95.396595] hub 2-0:1.0: hub_resume
[   95.396718] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.396725] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.396731] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.396870] hub 2-0:1.0: hub_suspend
[   95.396874] usb usb2: bus auto-suspend, wakeup 1
[   95.396881] usb usb2: bus suspend fail, err -16
[   95.396882] hub 2-0:1.0: hub_resume
[   95.396911] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.396917] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.396975] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.397063] hub 2-0:1.0: hub_suspend
[   95.397068] usb usb2: bus auto-suspend, wakeup 1
[   95.397095] usb usb2: bus suspend fail, err -16
[   95.397105] hub 2-0:1.0: hub_resume
[   95.397200] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.397207] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.397213] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.397367] hub 2-0:1.0: hub_suspend
[   95.397372] usb usb2: bus auto-suspend, wakeup 1
[   95.397379] usb usb2: bus suspend fail, err -16
[   95.397380] hub 2-0:1.0: hub_resume
[   95.397412] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.397418] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.397470] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.397560] hub 2-0:1.0: hub_suspend
[   95.397565] usb usb2: bus auto-suspend, wakeup 1
[   95.397599] usb usb2: bus suspend fail, err -16
[   95.397610] hub 2-0:1.0: hub_resume
[   95.397740] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.397746] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.397753] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.397888] hub 2-0:1.0: hub_suspend
[   95.397893] usb usb2: bus auto-suspend, wakeup 1
[   95.397900] usb usb2: bus suspend fail, err -16
[   95.397901] hub 2-0:1.0: hub_resume
[   95.397989] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.398030] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.398036] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.398120] hub 2-0:1.0: hub_suspend
[   95.398158] usb usb2: bus auto-suspend, wakeup 1
[   95.398189] usb usb2: bus suspend fail, err -16
[   95.398190] hub 2-0:1.0: hub_resume
[   95.398231] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.398237] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.398243] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.398381] hub 2-0:1.0: hub_suspend
[   95.398385] usb usb2: bus auto-suspend, wakeup 1
[   95.398392] usb usb2: bus suspend fail, err -16
[   95.398393] hub 2-0:1.0: hub_resume
[   95.398479] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.398523] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.398529] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.398620] hub 2-0:1.0: hub_suspend
[   95.398678] usb usb2: bus auto-suspend, wakeup 1
[   95.398685] usb usb2: bus suspend fail, err -16
[   95.398686] hub 2-0:1.0: hub_resume
[   95.398717] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.398724] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.398730] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.398869] hub 2-0:1.0: hub_suspend
[   95.398874] usb usb2: bus auto-suspend, wakeup 1
[   95.398880] usb usb2: bus suspend fail, err -16
[   95.398882] hub 2-0:1.0: hub_resume
[   95.399004] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.399011] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.399016] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.399152] hub 2-0:1.0: hub_suspend
[   95.399157] usb usb2: bus auto-suspend, wakeup 1
[   95.399164] usb usb2: bus suspend fail, err -16
[   95.399165] hub 2-0:1.0: hub_resume
[   95.399194] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.399201] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.399241] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.399346] hub 2-0:1.0: hub_suspend
[   95.399350] usb usb2: bus auto-suspend, wakeup 1
[   95.399357] usb usb2: bus suspend fail, err -16
[   95.399358] hub 2-0:1.0: hub_resume
[   95.399481] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.399488] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.399493] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.399630] hub 2-0:1.0: hub_suspend
[   95.399634] usb usb2: bus auto-suspend, wakeup 1
[   95.399641] usb usb2: bus suspend fail, err -16
[   95.399642] hub 2-0:1.0: hub_resume
[   95.399671] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.399707] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.399750] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.399934] hub 2-0:1.0: hub_suspend
[   95.399985] usb usb2: bus auto-suspend, wakeup 1
[   95.399992] usb usb2: bus suspend fail, err -16
[   95.399995] hub 2-0:1.0: hub_resume
[   95.400027] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.400034] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.400093] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.400228] hub 2-0:1.0: hub_suspend
[   95.400233] usb usb2: bus auto-suspend, wakeup 1
[   95.400267] usb usb2: bus suspend fail, err -16
[   95.400276] hub 2-0:1.0: hub_resume
[   95.400363] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.400370] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.400377] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.400514] hub 2-0:1.0: hub_suspend
[   95.400519] usb usb2: bus auto-suspend, wakeup 1
[   95.400526] usb usb2: bus suspend fail, err -16
[   95.400527] hub 2-0:1.0: hub_resume
[   95.400558] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   95.400565] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
[   95.400571] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
[   95.400709] hub 2-0:1.0: hub_suspend
[   95.400714] usb usb2: bus auto-suspend, wakeup 1
[   95.400721] usb usb2: bus suspend fail, err -16
[   95.400722] hub 2-0:1.0: hub_resume
-- 
Michal Hocko
SUSE Labs
