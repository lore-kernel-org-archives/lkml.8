Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFD5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFD220838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597426472;
	bh=A1FAH9u3u65dfV6g6mCRxVU/h13SIywVw7os47ug6xU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tPsitH0pSpXP7IJxHUvagtWM5EgJYprLn/2T6eSuQiox96vudYyr78lrb1eCyvvdh
	 99ADhThP6m86RGiDqA2v7ga/6u3gEePQ2hbPmPca03om0nQOgDgKW7wuNuLwYbKw1Y
	 9tTJh5OHILfFJbVGSzLs6R7TXfzXovG5mHw9vQV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgHNRe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:34:27 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:41607 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:34:20 -0400
Received: by mail-io1-f48.google.com with SMTP id g19so11509153ioh.8;
        Fri, 14 Aug 2020 10:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRLUQXT1FjeDUoDxrxVid7a8LubFJ4oZ02ezybrYxg4=;
        b=dG/QbddHpusCjE7yQUPHaFYljR7NxS4gPwgJ/jXFDmlsq0VfyERxNrXL+a3hwY/8jo
         3uaIDnB2XsrqvYLPlnt4oDKJsyqr9Rfu2RZmZixvIeRf40WdCCxBUWk3fs//jmeZkDfx
         06tfsrOsF5rRpZDtMUig9ejyCn/Mlhsv7b2QhGLSmXVbDqTKrSdVqaYN+AVvB5MP9Njn
         +pZ6SMsuih2LLCFNn614XVCJ6969q974BazSpIurAsrCkydc1WpUSt0K6yoXKf0FOZSW
         skjALzH03VOhjC96IlDDT+pAzvWzOuEf+GG5uQU7kPFTTJqIm4lS/HjxRYAdD2Y5Q2eM
         wbhQ==
X-Gm-Message-State: AOAM532qPYlBgtfHViNSO8q+GF9swneYJSIcVlJcJB3xKLfHczhve2Ca
        Uss/BJwVZWEXoyqilFx/ax/EyMb1zw==
X-Google-Smtp-Source: ABdhPJzF09ie4qqybp5M2WwpWzXEM1ABAQT6ujc2ahD2sHd9PZDZ93rPchRaX4zjJPhtADyu0He4yg==
X-Received: by 2002:a02:852c:: with SMTP id g41mr3723855jai.58.1597426459238;
        Fri, 14 Aug 2020 10:34:19 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id x185sm4637575iof.41.2020.08.14.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 10:34:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrei Ziureaev <andrei.ziureaev@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/3] DT validation time improvements
Date:   Fri, 14 Aug 2020 11:34:14 -0600
Message-Id: <20200814173417.2322509-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time to run dt_binding_check and dtbs_check has gotten
significantly slower as the number of schemas has increased. There's 2 
main factors causing validation time on each file to be slow. 

The first is python start-up time. This is a common problem for python 
without much of a solution other than minimizing module imports. 
Eliminating some imports was possible for dt-extract-example, but not 
the other tools. Validating multiple files in a single call is the 
simplest solution. The downside of processing multiple files in one call 
is losing make dependency handling. This is not too important for 
dt-doc-validate as the validation time is <10 sec. 

The 2nd factor is processed-schema*.yaml is now ~2MB and around 2 sec to 
parse (which is done for every .dts and example). Switching 
processed-schema*.yaml to JSON is much faster to parse 

The overall result of these changes is a 2x improvement to dtbs_check 
and a 4-5x improvement to dt_binding_check.

Rob

Andrei Ziureaev (1):
  dt-bindings: Use json for processed-schema*

Rob Herring (2):
  dt-bindings: Bump minimum version of dtschema to 2020.8
  dt-bindings: Validate DT binding schema in a single call

 Documentation/devicetree/bindings/.gitignore |  1 +
 Documentation/devicetree/bindings/Makefile   | 45 ++++++++++++--------
 scripts/Makefile.lib                         |  2 +-
 3 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.25.1

